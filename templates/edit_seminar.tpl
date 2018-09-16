<!doctype html>
<html>
  <head>
      <title>Edit Seminar</title>
      %sem_id = seminar[0]
      %title = seminar[1]
      %description = seminar[2]
      %first_day_note = seminar[3]
      %capacity = seminar[4]
      %cost = seminar[5]
      %sign_up = seminar[6]
      %no_random = seminar[7]

      <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
      <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
      <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
      <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
      <link rel="stylesheet" href="/css/style.css">
      
  </head>
  <body>
      <script>
       var teachers = {{!teachers}};

       var selected_teachers = {{!selected_teachers}}
      </script>

      <div id="root">
	  <h1>Edit Seminar:</h1>

	  <form action="/teacher/edit/save" method="POST" id="form" v-on:submit.prevent>
	      <input type="hidden" name="sems_id" value="{{sems_id}}">
	      <input type="hidden" name="sem_id" value="{{sem_id}}">

	      <label for="semTitle">Seminar Title:</label>
	      <input type="text" id="semTitle" name="title" :value="title">
	      <div>
		  <label for="semDescription">Seminar Description:</label>
		  <textarea id="semDescription" name="description" style="width:100%" :value="description"></textarea>
	      </div>
	      <label for="firstDay">First Day Note:</label>
	      <small class="form-text text-muted" >
		  This will be given to students before their first seminar.
	      </small>
	      <textarea id="firstDay" name="first_day_note" style="width:100%" :value="first_day_note"></textarea>
	      <label for="capacity">Capacity:</label>
	      <input id="capacity" type="number" name="capacity" :value="capacity" >
	      <label for="cost">Cost:</label>
	      <input id="cost" type="number" name="cost" :value="cost" >
	      <div>
		  <label for="sign_up" >Sign Up Only:</label>
		  <input id="sign_up" type="checkbox" name="sign_up" :checked="sign_up" >
		  <small class="form-text text-muted" >
		      If this is checked, students will not be able to choose this seminar, and must be pulled in by you.
		  </small>
	      </div>
	      <div>
		  <label for="no_random" >Prevent Random Assignment:</label>
		  <input id="no_random" type="checkbox" name="no_random" :checked="no_random">
		  <small class="form-text text-muted" >
		      If this is checked, only students who actively ranked this seminar will be assigned to it. Otherwise, students may be randomly assigned to it
		  </small>
	      </div>
	      <label for="session" >Session:</label>
	      <select id="session" name="session" v-model="session" required>
		  <option value="1" >First Session</option>
		  <option value="2" >Second Session</option>
		  <option value="3" >Double Session</option>
	      </select>
	      <label for="room" >Room:</label>
	      <select id="room" name="room" v-model="selected_room_id" required>
		  <option v-for="room in all_rooms" :value="room[0]"><{room[1]}></option>
	      </select>
	      <div>
		  <label for="assignedTeachers"> Assigned Teachers: </label>
		  <span v-for="selected_t in selected_teachers" id="assignedTeachers">
		      <input type="hidden" name="teacher" :value="selected_t[0]">
		      <button class="btn btn-outline-primary" v-on:click="RemoveTeacher(selected_t)" ><{selected_t[1]}><i class="fas fa-times" style="padding-left:10px"></i></button>
		  </span>
	      </div>
	  </form>
	  <select ref="teacher_selector" class="custom-select" required style="width:15em">
	      <option selected disabled hidden>Select a teacher</option>
	      <option v-for="teacher in teachers" :value="teacher[0]"><{teacher[1]}></option>
	  </select>

	  <button type="button" class="btn btn-primary" v-on:click="AddTeacher">Add Selected Teacher</button>

	  <div class="navFooter">
	      <form action="/teacher/edit/select" method="GET" id="back"></form>

		  <button type="button" class="btn" onclick="document.getElementById('back').submit();">Back</button>
		  <button type="button" class="btn btn-primary" onclick="document.getElementById('form').submit();">Save</button>
	  </div>

      </div>

	  
      <script>
       var app = new Vue
       ({
	   el:'#root',
	   data:{
	       title:"{{title}}",
	       description:"{{description}}",
	       first_day_note:"{{first_day_note}}",
	       capacity:{{capacity}},
	       cost:{{cost}},
	       sign_up:{{sign_up}},
	       no_random:{{no_random}},
	       selected_room_id:"{{room_id}}",
	       all_rooms:{{!all_rooms}},
	       session:"{{session}}",
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
  </body>
</html>
