%sem_id = seminar[0]
%title = seminar[1]
%description = seminar[2]

<p>Edit Seminar:</p>

<form action="edit" method="POST" id="form">
	<input type="hidden" name="sem_id" value="{{sem_id}}">
	<input type="text" name="title" value={{title}}>
	<input type="text" name="description" value={{description}}>
	<input type="submit" name="save" value="save">
	
</form>

<button type="button" onclick="AddTeacher()">Add Teacher</button>

<script>
function AddTeacher(){
	document.getElementById("form").innerHTML += {{!teacher_dropdown}};
}
</script>