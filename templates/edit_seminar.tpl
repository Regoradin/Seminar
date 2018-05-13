%sem_id = seminar[0]
%title = seminar[1]
%description = seminar[2]

<script>
  var teachers = {{!teachers}};
</script>

<p>Edit Seminar:</p>

<form action="edit" method="POST" id="form">
	<input type="hidden" name="sem_id" value="{{sem_id}}">
	<input type="text" name="title" value={{title}}>
	<input type="text" name="description" value={{description}}>
	<input type="submit" name="save" value="save">
	
</form>

<div id="teacher_select"></div>

<button type="button" onclick="AddTeacher(teachers)">Add Teacher</button>

<script src="/js/scripts.js"></script>
