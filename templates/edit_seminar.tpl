<!doctype html>
<html>
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

  <select ref="teacher_selector" required>
    <option selected disabled hidden>Select a teacher</option>
    <option v-for="teacher in teachers" :value="teacher[0]"><{teacher[1]}></option>
  </select>
    
  <button type="button" v-on:click="AddTeacher">Add Teacher</button>

  <form action="edit" method="POST">
    <input type="submit" value="Back">
  </form>

</div>

<script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
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
	     var selected = this.$refs.teacher_selector;
	     if(!selected.options[selected.selectedIndex].disabled){
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
</html>
