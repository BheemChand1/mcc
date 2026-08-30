const operations = [
  {color:'#02d66f',icon:'▣',train:'16231 – YPR DEMU',type:'MCC Normal Cleaning',loc:'Pit Line 1',coaches:'22',start:'04:32 AM',man:'28 / 28',prog:82,score:'92.4%',status:'In Progress',kind:'on'},
  {color:'#03c8ff',icon:'▣',train:'16535 – KSR Bengaluru Exp',type:'Inspection',loc:'Pit Line 2',coaches:'22',start:'05:10 AM',man:'30 / 30',prog:100,score:'94.0%',status:'Inspection',kind:'inspect'},
  {color:'#9239e8',icon:'▣',train:'PFTR OPERATIONS',type:'PFTR Cleaning',loc:'PFTR Bay',coaches:'521 / 525',start:'–',man:'102 / 105',prog:96,score:'–',status:'In Progress',kind:'on'},
  {color:'#f1ae00',icon:'♟',train:'22833 – VANDE BHARAT',type:'14 Min Cleaning',loc:'Platform 4',coaches:'16',start:'10:16 AM',man:'24 / 24',prog:null,score:'–',status:'In Progress',kind:'on',timer:true},
  {color:'#03aef0',icon:'▣',train:'ACWP OPERATION',type:'ACWP Cleaning',loc:'Pit Line 3',coaches:'Rake 01',start:'06:20 AM',man:'18 / 20',prog:68,score:'–',status:'At Risk',kind:'risk'},
  {color:'#f05400',icon:'♟',train:'INTENSIVE CLEANING',type:'MCC Intensive',loc:'Pit Line 1',coaches:'Rake 03',start:'07:45 AM',man:'26 / 28',prog:76,score:'88.6%',status:'At Risk',kind:'risk'},
  {color:'#00c56a',icon:'△',train:'DEPOT CLEANING',type:'Depot / Yard Cleaning',loc:'Yard Area',coaches:'–',start:'06:00 AM',man:'22 / 24',prog:96,score:'–',status:'In Progress',kind:'on'}
];
const tbody = document.getElementById('operationsBody');
operations.forEach(o=>{
  const tr=document.createElement('tr');
  tr.innerHTML=`<td><div class="train-cell"><span class="train-badge" style="background:${o.color}">${o.icon}</span>${o.train}</div></td><td>${o.type}</td><td>${o.loc}</td><td>${o.coaches}</td><td>${o.start}</td><td>${o.man}</td><td class="progress-cell">${o.timer?'<div class="timer" id="vbTimer">08:32<small>Time Remaining</small></div>':`${o.prog}%<div class="progress-track"><i style="width:${o.prog}%"></i></div>`}</td><td>${o.score}</td><td><span class="status ${o.kind}">${o.status} ›</span></td>`;
  tbody.appendChild(tr);
});
const insights=[
  ['tone-red','◴','Delay Prediction','2 rakes likely to get delayed in next 2 hours'],
  ['tone-amber','♟','Manpower Shortage','17 staff shortage predicted for PFTR shift-2'],
  ['tone-amber','▥','Low Score Risk','3 rakes predicted with score below 80%'],
  ['tone-purple','⚗','Chemical Consumption','Floor cleaner consumption 23% above normal'],
  ['tone-green','♧','Performance Forecast',"Today's Avg Cleaning Score predicted to be 94%"]
];
document.getElementById('insightList').innerHTML=insights.map(x=>`<div class="insight"><span class="insight-icon ${x[0]}">${x[1]}</span><div><strong class="${x[0]}">${x[2]}</strong><p>${x[3]}</p></div><a href="#">View Details</a></div>`).join('');
const summary=[['#d0f100','▣','MCC Normal Cleaning','174 / 188 Coaches','92%'],['#16dc66','▣','MCC Intensive Cleaning','18 / 22 Coaches','82%'],['#00a4ff','▣','PFTR Cleaning','521 / 525 Coaches','99%'],['#933bff','▣','14 Min Vande Bharat','3 / 4 Rakes','75%'],['#ff4034','♟','ACWP Operation','5 / 6 Rakes','83%'],['#f0ad00','△','Depot Cleaning','96% Completed','']];
document.getElementById('summaryList').innerHTML=summary.map(s=>`<div class="summary-line"><span class="summary-name"><i class="summary-icon" style="background:${s[0]};color:#06202a">${s[1]}</i>${s[2]}</span><span class="summary-val">${s[3]}</span><span class="summary-score">${s[4]}</span></div>`).join('');
const man=[['#0ba95c','MCC Normal','101 (30.9%)'],['#149be0','PFTR','105 (32.2%)'],['#5a3de0','ACWP','54 (16.6%)'],['#e9a90b','Intensive','28 (8.6%)'],['#933ce3','VB Cleaning','24 (7.4%)'],['#6336a5','Depot Cleaning','14 (4.3%)']];
const mach=[['#10a95d','Operational','47 (84%)'],['#86a00d','Under Repair','3 (5%)'],['#e28b00','Due Inspection','5 (9%)'],['#e13c32','Not Available','1 (2%)']];
function legend(target,items){document.getElementById(target).innerHTML=items.map(i=>`<div class="legend-row"><i style="background:${i[0]}"></i><span>${i[1]}</span><em>${i[2]}</em></div>`).join('')}
legend('manpowerLegend',man);legend('machineLegend',mach);
const html=document.documentElement;const themeBtn=document.getElementById('themeToggle');
function setTheme(t){html.dataset.theme=t;themeBtn.textContent=t==='dark'?'☼':'☾';localStorage.setItem('mcc-theme',t)}
setTheme(localStorage.getItem('mcc-theme')||'dark');themeBtn.addEventListener('click',()=>setTheme(html.dataset.theme==='dark'?'light':'dark'));
document.getElementById('sidebarToggle').addEventListener('click',()=>document.body.classList.toggle('sidebar-collapsed'));
document.getElementById('fullscreenBtn').addEventListener('click',()=>document.fullscreenElement?document.exitFullscreen():document.documentElement.requestFullscreen());
let seconds=8*60+32;setInterval(()=>{seconds=Math.max(0,seconds-1);const el=document.getElementById('vbTimer');if(el){const m=String(Math.floor(seconds/60)).padStart(2,'0'),s=String(seconds%60).padStart(2,'0');el.innerHTML=`${m}:${s}<small>Time Remaining</small>`}},1000);
setInterval(()=>{document.getElementById('syncTime').textContent=new Date().toLocaleTimeString([], {hour:'2-digit',minute:'2-digit',second:'2-digit'})},1000);
