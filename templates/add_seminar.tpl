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
	    <form action="add" method="POST">
		<input type="text" name="title" value="Title" required>
		<input type="text" name="description" value="Description" required>
		<input type="text" name="first_day_note" value="First Day note" required>
		<input type="number" name="capacity" value="Capacity" required>
		<input type="number" name="cost" value="Cost" required>
		<input type="checkbox" name="sign_up" value="1" >
		<input type="checkbox" name="no_random" value="1" >
		<select name="session" required>
		    <option selected disabled hidden>Select Session</option>
		    <option value="1" >First Session</option>
		    <option value="2" >Second Session</option>
		    <option value="3" >Double Session</option>
		</select>
		<select name="room_id" required>
		    <option selected disabled hidden>Select Room</option>
		    <option v-for="room in rooms"  :value="room[0]"><{room[1]}></option>
		</select>
		<select v-for="i in teacher_count" name="teacher" required>
		    <option selected disabled hidden>Select Teacher</option>
		    <option v-for="teacher in teachers" :value="teacher[0]"><{teacher[1]}></option>
		</select>
		
		<input type="submit" name="save" value="Add Seminar">
	    </form>

	    <button v-on:click="teacher_count += 1">Add Teacher</button>
	    <button v-on:click="teacher_count -= teacher_count > 1 ? 1 : 0">Remove Teacher</button>
	    
	    <form action = "/teacher">
		<input type="submit" value="Back">
	    </form>
	</div>

	<script>
	 var app = new Vue
	 ({
	     el:'#root',
	     data:{
		 teachers: {{!teachers}},
		 teacher_count:1,
		 rooms: {{!rooms}}
	     },
	     delimiters:["<{", "}>"]
	 })
	</script>
    </body>
</html>
