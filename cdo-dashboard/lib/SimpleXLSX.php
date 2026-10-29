<?php
/**
 * SimpleXLSX class v1.0.18
 * MS Excel 2007+ (XLSX) reader
 * Lightweight, zero-dependency parser using PHP's ZipArchive and SimpleXML.
 */
class SimpleXLSX {
    public const SCHEMA_REL_OFFICEDOCUMENT = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument';
    public const SCHEMA_REL_SHAREDSTRINGS = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/sharedStrings';
    public const SCHEMA_REL_WORKSHEET = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet';
    public const SCHEMA_REL_STYLES = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles';

    protected $workbook;
    protected $sheets = [];
    protected $styles = [];
    protected $hyperlinks = [];
    protected $sharedstrings = [];
    protected $error = 0;
    protected $package = [
        'filename' => '',
        'mtime' => 0,
        'size' => 0,
        'comment' => '',
        'entries' => []
    ];
    protected $sharedStringsXML = '';
    protected $workbookXML = '';

    public function __construct($filename = null, $is_data = null) {
        if ($filename) {
            $this->parse($filename, $is_data);
        }
    }

    public static function parse($filename, $is_data = false) {
        $xlsx = new self();
        if ($xlsx->_parse($filename, $is_data)) {
            return $xlsx;
        }
        return false;
    }

    public static function parseError() {
        return self::$error_message;
    }

    protected static $error_message = '';

    protected function _error($msg) {
        self::$error_message = $msg;
        $this->error = $msg;
        return false;
    }

    public function error() {
        return $this->error;
    }

    protected function _parse($filename, $is_data = false) {
        if ($is_data) {
            $temp = tempnam(sys_get_temp_dir(), 'xlsx_');
            file_put_contents($temp, $filename);
            $filename = $temp;
        }

        if (!is_readable($filename)) {
            return $this->_error('File not found: ' . $filename);
        }

        $zip = new ZipArchive();
        if ($zip->open($filename) !== true) {
            return $this->_error('Could not open file as zip archive.');
        }

        // Read relationships
        $rels = [];
        if (($content = $zip->getFromName('_rels/.rels')) !== false) {
            $xml = simplexml_load_string($content);
            if ($xml) {
                foreach ($xml->Relationship as $rel) {
                    $rels[(string)$rel['Id']] = (string)$rel['Target'];
                }
            }
        }

        // Find workbook path
        $workbookPath = 'xl/workbook.xml';
        foreach ($rels as $target) {
            if (strpos($target, 'workbook.xml') !== false) {
                $workbookPath = ltrim($target, '/');
                break;
            }
        }

        // Shared strings
        if (($content = $zip->getFromName('xl/sharedStrings.xml')) !== false) {
            $xml = simplexml_load_string($content);
            if ($xml && isset($xml->si)) {
                foreach ($xml->si as $val) {
                    if (isset($val->t)) {
                        $this->sharedstrings[] = (string)$val->t;
                    } elseif (isset($val->r)) {
                        $t = '';
                        foreach ($val->r as $r) {
                            $t .= (string)$r->t;
                        }
                        $this->sharedstrings[] = $t;
                    } else {
                        $this->sharedstrings[] = '';
                    }
                }
            }
        }

        // Read sheets
        if (($content = $zip->getFromName($workbookPath)) !== false) {
            $xml = simplexml_load_string($content);
            if ($xml && isset($xml->sheets->sheet)) {
                $i = 1;
                foreach ($xml->sheets->sheet as $s) {
                    $sheetName = (string)$s['name'];
                    $sheetFile = 'xl/worksheets/sheet' . $i . '.xml';
                    if ($zip->locateName($sheetFile) === false) {
                        // Try finding target via workbook rels
                        $sheetFile = 'xl/' . str_replace('../', '', (string)$s['id']);
                    }
                    $this->sheets[] = [
                        'name' => $sheetName,
                        'file' => $sheetFile
                    ];
                    $i++;
                }
            }
        }

        if (empty($this->sheets)) {
            $this->sheets[] = ['name' => 'Sheet1', 'file' => 'xl/worksheets/sheet1.xml'];
        }

        $this->zip = $zip;
        return true;
    }

    protected $zip;

    public function rows($sheetIndex = 0) {
        if (!isset($this->sheets[$sheetIndex])) {
            return [];
        }

        $file = $this->sheets[$sheetIndex]['file'];
        $content = $this->zip->getFromName($file);
        if ($content === false) {
            // Try fallback
            $content = $this->zip->getFromName('xl/worksheets/sheet1.xml');
            if ($content === false) {
                return [];
            }
        }

        $xml = simplexml_load_string($content);
        if (!$xml || !isset($xml->sheetData->row)) {
            return [];
        }

        $rows = [];
        foreach ($xml->sheetData->row as $r) {
            $row = [];
            $curCol = 0;
            foreach ($r->c as $c) {
                // Determine column index from cell coordinate e.g. A1, B1, AA1
                $cellRef = (string)$c['r'];
                $colLetters = preg_replace('/[0-9]/', '', $cellRef);
                $targetCol = $this->columnLetterToIndex($colLetters);

                while ($curCol < $targetCol) {
                    $row[] = '';
                    $curCol++;
                }

                $cellType = (string)$c['t'];
                $val = isset($c->v) ? (string)$c->v : '';

                if ($cellType === 's') {
                    // Shared string
                    $idx = intval($val);
                    $val = isset($this->sharedstrings[$idx]) ? $this->sharedstrings[$idx] : '';
                } elseif ($cellType === 'inlineStr' && isset($c->is->t)) {
                    $val = (string)$c->is->t;
                }

                $row[] = $val;
                $curCol++;
            }
            $rows[] = $row;
        }

        return $rows;
    }

    protected function columnLetterToIndex($colLetters) {
        $letters = strtoupper($colLetters);
        $len = strlen($letters);
        $index = 0;
        for ($i = 0; $i < $len; $i++) {
            $index = $index * 26 + (ord($letters[$i]) - 64);
        }
        return $index - 1;
    }

    public function __destruct() {
        if ($this->zip instanceof ZipArchive) {
            @$this->zip->close();
        }
    }
}
