<!doctype html>
<html>
    <head>
	<title>Add New Seminar</title>

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
	<link rel="stylesheet" href="/css/style.css">
	
    </head>
    <body>
	<div id="root">
	    <h1>Add Seminar</h1>
	    
	    <form action="add" method="POST" id="form" v-on:submit.prevent>
		<label for="semTitle" >Seminar Title:</label>
		<input type="text" id="semTitle" name="title" value="Title" required>
		<div>
		    <label for="semDescription" >Seminar Description: </label>
		    <textarea id="semDescription" name="description" style="width:100%" ></textarea>
		</div>
		<div>
		    <label for="first_day_note" >First Day note:</label>
		    <small class="form-text text-muted" >
			This will be given to students before their first seminar.
		    </small>
		    <textarea id="first_day_note" name="first_day_note" style="width:100%"></textarea>
		</div>
		<label for="capacity" >Capacity:</label>
		<input type="number" id="capacity" name="capacity" value="Capacity" required>
		<label for="cost" >Cost:</label>
		<input type="number" id="cost" name="cost" value="Cost" required>
		<div>
		    <label for="sign_up" >Sign Up Only:</label>
		    <input id="sign_up" type="checkbox" name="sign_up" >
		    <small class="form-text text-muted" >
			If this is checked, students will not be able to choose this seminar, and must be pulled in by you.
		    </small>
		</div>
		<div>
		    <label for="no_random" >Prevent Random Assignment:</label>
		    <input id="no_random" type="checkbox" name="no_random" >
		    <small class="form-text text-muted" >
			If this is checked, only students who actively ranked this seminar will be assigned to it. Otherwise, students may be randomly assigned to it
		    </small>
		</div>
		<label for="session" >Session:</label>
		<select name="session" id="session" required>
		    <option selected disabled hidden>Select Session</option>
		    <option value="1" >First Session</option>
		    <option value="2" >Second Session</option>
		    <option value="3" >Double Session</option>
		</select>
		<label for="room" >Room:</label>
		<select name="room_id" id="room" required>
		    <option selected disabled hidden>Select Room</option>
		    <option v-for="room in rooms"  :value="room[0]"><{room[1]}></option>
		</select>


		<div>
		    <label for="assignedTeachers"> Assigned Teachers: </label>
		    <span v-for="selected_t in selected_teachers" id="assignedTeachers">
			<input type="hidden" name="teacher" :value="selected_t[0]">
			<button class="btn btn-outline-primary" v-on:click="RemoveTeacher(selected_t)" ><{selected_t[1]}><i class="fas fa-times" style="padding-left:10px"></i></button>
		    </span>
		</div>

		
		<select ref="teacher_selector" class="custom-select" name="teacher_selector" required style="width:15em">
		    <option selected disabled hidden>Select Teacher</option>
		    <option v-for="teacher in teachers" :value="teacher[0]"><{teacher[1]}></option>
		</select>
		
		<button type="button" class="btn btn-primary" v-on:click="AddTeacher">Add Selected Teacher</button>



		<div class="navFooter">
		    <button class="btn" onclick=" window.location='/teacher'">Back</button>
		    <button class="btn btn-primary" onclick="document.getElementById('form').submit();" >Add Seminar</button>
		</div>
	    </form>
	    
	</div>

	<script>
	 var app = new Vue
	 ({
	     el:'#root',
	     data:{
		 teachers: {{!teachers}},
		 selected_teachers: [],
		 rooms: {{!rooms}}
	     },
	     delimiters:["<{", "}>"],
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
	 })
	</script>
    </body>
</html>
