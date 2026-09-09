<?php
require_once '../auth.php';

$pageTitle = 'Manpower Log | CDO';
$extraStyles = "";
?>

<?php include '../header.php'; ?>
<?php include '../sidebar.php'; ?>

<style>
.page{padding:20px 20px 14px}
.toolbar{display:flex;align-items:center;gap:10px;flex-wrap:nowrap;overflow-x:auto;background:#fff;border:1px solid #dce2e7;border-radius:11px;padding:12px 16px;box-shadow:0 3px 12px rgba(0,0,0,.15);margin-bottom:28px}
.toolbar label{font-weight:700;font-size:14px}
.datebox{height:38px;width:175px;border:1.5px solid #0d5584;border-radius:3px;padding:0 12px;font-weight:700;background:#fff}
.btn{height:38px;border:none;border-radius:7px;padding:0 16px;color:#fff;font-weight:700;cursor:pointer;box-shadow:0 2px 5px rgba(0,0,0,.12);display:inline-flex;align-items:center;justify-content:center;text-decoration:none;white-space:nowrap;flex-shrink:0}
.btn.cyan{background:#14aee8}.btn.dark{background:#053151}.btn.blue{background:#188fc4;border:1px solid #0c638f}
.report-shell{background:#eee;border:1px solid #b9b9b9;padding:12px 10px 14px;min-height:680px}
.tabs{display:flex;gap:2px;margin:0 0 16px;padding:0 2px}
.tab-btn{border:1px solid #0c527d;background:#eaf2f8;color:#0b3551;padding:12px 18px;font-weight:800;cursor:pointer;border-radius:8px 8px 0 0;font-size:14px;white-space:nowrap}
.tab-btn.active{background:#062f50;color:#fff;border-color:#062f50}
.report-card{background:#fff;border:1px solid #c7c7c7;padding:14px 10px 0}
.report-title{text-align:center;font-size:23px;font-weight:800;margin:4px 0 22px}
.meta-grid{display:grid;grid-template-columns:repeat(4,minmax(180px,1fr));gap:13px 28px;max-width:1080px;margin:0 auto 18px;font-size:13px}
.meta{display:flex;justify-content:center;gap:5px;white-space:nowrap}.meta strong{font-weight:800}
.table-wrap{overflow:auto;border:1px solid #111}table{width:100%;border-collapse:collapse;min-width:1010px;background:#fff}thead th{background:#062e4e;color:#fff;font-size:13px;padding:12px 10px;border:1px solid #245474;text-align:center}tbody td{font-size:13px;padding:9px 10px;border:1px solid #c8c8c8;text-align:center}tbody td.name{text-align:left;font-weight:700}.shift-row td{background:#e8f2fb;color:#073957;font-weight:800;text-align:left;padding:8px 11px;border-color:#abc6d9}.badge{display:inline-block;min-width:66px;padding:4px 8px;border-radius:12px;font-size:11px;font-weight:800}.s1{background:#dff5e8;color:#127847}.s2{background:#fff1d7;color:#9a6400}.s3{background:#e8e3ff;color:#5b3eb8}.report-panel{display:none}.report-panel.active{display:block}
@media(max-width:1100px){.meta-grid{grid-template-columns:repeat(2,minmax(180px,1fr))}.datebox{width:210px}}
@media(max-width:800px){.toolbar{padding:10px;gap:8px}.datebox{width:150px}.meta-grid{grid-template-columns:1fr}}
@media print{.app-header,.app-sidebar,.app-footer,.toolbar,.tabs,.no-print{display:none!important}.app-main{margin:0!important;padding:0!important}.report-shell{border:none;padding:0;background:#fff}.report-panel{display:none!important}.report-panel.active{display:block!important}.report-card{border:none}.table-wrap{border:1px solid #000}}
</style>

<main class="app-main">
  <div class="app-content">
    <div class="container-fluid">
      <section class="page">
        <div class="toolbar no-print">
          <label>From:</label><input id="fromDate" class="datebox" type="date">
          <label>To:</label><input id="toDate" class="datebox" type="date">
          <button class="btn cyan" onclick="syncReportDate()">Go</button>
          <button class="btn dark" onclick="window.print()">Print</button>
          <a class="btn blue" href="">Manpower Target</a>
          <a class="btn blue" href="">Manpower Penalty</a>
          <a class="btn blue" href="">Summary</a>
        </div>
        <div class="report-shell">
          <div class="tabs no-print">
            <button class="tab-btn active" data-tab="depot">Manpower Report for Coaching Depot</button>
            <button class="tab-btn" data-tab="prt">Manpower Report for Platform Return Trains</button>
          </div>
          <section id="depot" class="report-panel active">
            <div class="report-card">
              <div class="report-title">Manpower Report for Coaching Depot</div>
              <div class="meta-grid">
                <div class="meta"><strong>Railway:</strong> SOUTH WESTERN RAILWAY</div>
                <div class="meta"><strong>Date:</strong> <span class="current-date"></span></div>
                <div class="meta"><strong>Division:</strong> Mysuru</div>
                <div class="meta"><strong>Station:</strong> Mysore Junction</div>
                <div class="meta" style="grid-column:span 2"><strong>Contractor Name:</strong> SMC Integrated Facility Management Solutions</div>
                <div class="meta"><strong>Target Manpower:</strong> 25</div>
                <div class="meta"><strong>Total Present:</strong> 25</div>
              </div>
              <div class="table-wrap"><table id="depotTable"></table></div>
            </div>
          </section>
          <section id="prt" class="report-panel">
            <div class="report-card">
              <div class="report-title">Manpower Report for Platform Return Trains</div>
              <div class="meta-grid">
                <div class="meta"><strong>Railway:</strong> SOUTH WESTERN RAILWAY</div>
                <div class="meta"><strong>Date:</strong> <span class="current-date"></span></div>
                <div class="meta"><strong>Division:</strong> Mysuru</div>
                <div class="meta"><strong>Station:</strong> Mysore Junction</div>
                <div class="meta" style="grid-column:span 2"><strong>Contractor Name:</strong> SMC Integrated Facility Management Solutions</div>
                <div class="meta"><strong>Target Manpower:</strong> 25</div>
                <div class="meta"><strong>Total Present:</strong> 25</div>
              </div>
              <div class="table-wrap"><table id="prtTable"></table></div>
            </div>
          </section>
        </div>
      </section>
    </div>
  </div>
</main>
<script>
const depotNames=["Ramesh Kumar","Arun Prakash","Suresh Gowda","Manoj Kumar","Vijay Shetty","Mahesh Babu","Ravi Shankar","Anil Kumar","Pradeep Rao","Santosh Naik","Deepak Kumar","Naveen Raj","Ganesh Murthy","Harish Kumar","Ajay Singh","Kiran Kumar","Dinesh Yadav","Rajesh Patil","Mohan Lal","Sunil Kumar","Ashok Reddy","Pawan Kumar","Lokesh Gowda","Vinod Kumar","Shankar Rao"];
const prtNames=["Amit Verma","Rahul Sharma","Sanjay Kumar","Vikas Singh","Rohit Yadav","Mukesh Patel","Naresh Kumar","Gopal Das","Keshav Rao","Sandeep Naik","Rakesh Kumar","Prakash Jha","Chandan Singh","Suraj Kumar","Devendra Rao","Akash Mishra","Manish Gupta","Nitin Kumar","Bhaskar Reddy","Arvind Kumar","Kamal Kishore","Jitendra Singh","Madhav Rao","Tarun Joshi","Hemant Kumar"];
const loginTemplates=[["06:05:00","14:20:00"],["06:18:00","14:35:00"],["06:32:00","14:45:00"],["06:47:00","15:05:00"],["07:02:00","15:20:00"],["07:18:00","15:32:00"],["07:34:00","15:50:00"],["07:51:00","16:10:00"],["08:05:00","16:22:00"],["14:05:00","22:20:00"],["14:22:00","22:36:00"],["14:40:00","22:55:00"],["15:05:00","23:20:00"],["15:28:00","23:45:00"],["16:02:00","00:20:00"],["16:25:00","00:42:00"],["17:10:00","01:28:00"],["18:05:00","02:20:00"],["22:05:00","06:25:00"],["22:28:00","06:44:00"],["22:50:00","07:15:00"],["23:15:00","07:32:00"],["23:42:00","08:00:00"],["00:25:00","08:40:00"],["01:10:00","09:25:00"]];
const prtTemplates=[["06:12:00","14:30:00"],["06:26:00","14:50:00"],["06:41:00","15:00:00"],["06:56:00","15:15:00"],["07:12:00","15:30:00"],["07:29:00","15:48:00"],["07:46:00","16:05:00"],["08:02:00","16:22:00"],["08:18:00","16:35:00"],["14:10:00","22:28:00"],["14:28:00","22:48:00"],["14:46:00","23:05:00"],["15:14:00","23:35:00"],["15:42:00","00:03:00"],["16:18:00","00:40:00"],["16:52:00","01:12:00"],["17:35:00","01:55:00"],["18:20:00","02:42:00"],["22:12:00","06:34:00"],["22:36:00","06:58:00"],["22:58:00","07:20:00"],["23:22:00","07:45:00"],["23:48:00","08:10:00"],["00:38:00","09:02:00"],["01:22:00","09:45:00"]];
function pad(n){return String(n).padStart(2,"0")}function displayDate(d){return `${pad(d.getDate())}-${pad(d.getMonth()+1)}-${d.getFullYear()}`}function isoDate(d){return `${d.getFullYear()}-${pad(d.getMonth()+1)}-${pad(d.getDate())}`}
function seconds(t){const [h,m,s]=t.split(":").map(Number);return h*3600+m*60+s}function shiftOf(t){const s=seconds(t);if(s>=21600&&s<=50400)return 1;if(s>50400&&s<=79200)return 2;return 3}
function duration(login,logout){let a=seconds(login),b=seconds(logout);if(b<a)b+=86400;const d=b-a,h=Math.floor(d/3600),m=Math.floor((d%3600)/60),s=d%60;return `${pad(h)}:${pad(m)}:${pad(s)}`}
function makeData(names,templates,startId){return names.map((name,i)=>{const [login,logout]=templates[i];return{name,id:`EMP-${startId+i}`,login,logout,hours:duration(login,logout),shift:shiftOf(login)}}).sort((a,b)=>a.shift-b.shift||seconds(a.login)-seconds(b.login))}
const depotData=makeData(depotNames,loginTemplates,123),prtData=makeData(prtNames,prtTemplates,301);
function renderTable(id,rows){const d=document.getElementById("fromDate").value?new Date(document.getElementById("fromDate").value+"T00:00:00"):new Date();let html=`<thead><tr><th>S.No</th><th>Employee Name</th><th>Employee ID</th><th>Date</th><th>Login Time</th><th>Logout Time</th><th>Total Shift Hours</th><th>Shift</th></tr></thead><tbody>`,serial=1;[1,2,3].forEach(shift=>{html+=`<tr class="shift-row"><td colspan="8">Shift ${shift}</td></tr>`;rows.filter(r=>r.shift===shift).forEach(r=>{html+=`<tr><td>${serial++}</td><td class="name">${r.name}</td><td>${r.id}</td><td>${displayDate(d)}</td><td>${r.login}</td><td>${r.logout}</td><td>${r.hours}</td><td><span class="badge s${shift}">Shift ${shift}</span></td></tr>`})});document.getElementById(id).innerHTML=html+"</tbody>"}
function syncReportDate(){const d=document.getElementById("fromDate").value?new Date(document.getElementById("fromDate").value+"T00:00:00"):new Date();document.querySelectorAll(".current-date").forEach(e=>e.textContent=displayDate(d));renderTable("depotTable",depotData);renderTable("prtTable",prtData)}
document.querySelectorAll(".tab-btn").forEach(btn=>btn.addEventListener("click",()=>{document.querySelectorAll(".tab-btn").forEach(b=>b.classList.remove("active"));document.querySelectorAll(".report-panel").forEach(p=>p.classList.remove("active"));btn.classList.add("active");document.getElementById(btn.dataset.tab).classList.add("active")}));
const today=new Date();document.getElementById("fromDate").value=isoDate(today);document.getElementById("toDate").value=isoDate(today);syncReportDate();
</script>

<?php include '../footer.php'; ?>