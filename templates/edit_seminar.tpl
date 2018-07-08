
%sem_id = seminar[0]
%title = seminar[1]
%description = seminar[2]

<script>
  var teachers = {{!teachers}};

  var selected_teachers = {{!selected_teachers}}
</script>

<div id="root">
  <p>Edit Seminar:</p>

  <form action="edit" method="POST" id="form">
    <input type="hidden" name="sems_id" value="{{sems_id}}">
    <input type="hidden" name="sem_id" value="{{sem_id}}">
    <input type="text" name="title" :value="title">
    <input type="text" name="description" :value="description">
    <input type="submit" name="save" value="save">

    <div v-for="selected_t in selected_teachers">
      <input type="hidden" name="teacher" :value="selected_t[0]">
      <input type="button" v-on:click="RemoveTeacher(selected_t)"  :value="selected_t[1]">
    </div>
    
  </form>

  <select ref="teacher_selector">
    <option v-for="teacher in teachers" :value="teacher[0]"><{teacher[1]}></option>
  </select>
    
  <button type="button" v-on:click="AddTeacher">Add Teacher</button>

  <form action="edit" method="POST">
    <input type="submit" value="Back">
  </form>

  <div> <{title}> </div>

</div>
<script src="/js/scripts.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
<script src="/js/vue_scripts.js"></script>
<script>
  for (var i in selected_teachers){
//    AddTeacher(teachers, selected_teachers[i][0]);
//    RemoveTeacher(selected_teachers[i][0]);
  }
</script>
<script>
var app = new Vue
({
    el:'#root',
    data:{
	title:"{{title}}",
	description:"{{description}}",
	selected_teachers:{{!selected_teachers}},
	teachers:{{!teachers}}
    },
    delimiters: ["<{", "}>"],
    
    methods:{
	AddTeacher:function(){
	    var selected = app.$refs.teacher_selector;
	    var teacher = [parseInt(selected.value), selected.options[selected.selectedIndex].text];
	    var found = false;
	    for (i=0; i< app.selected_teachers.length; i++){
		if(app.selected_teachers[i][0] === teacher[0]){
		    found = true;
		}
	    }
	    if(!found){
		app.selected_teachers.push(teacher);
	    }
	},
	
	RemoveTeacher:function(teacher){	   
	    for (i=0; i< app.selected_teachers.length; i++){
		if(app.selected_teachers[i] === teacher){
		    app.selected_teachers.splice(i, 1);
		}
	    }
	}
    }
});
 

</script>
