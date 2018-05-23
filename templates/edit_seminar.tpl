%sem_id = seminar[0]
%title = seminar[1]
%description = seminar[2]

<script>
  var teachers = {{!teachers}};

  var selected_teachers = {{!selected_teachers}}
</script>

<p>Edit Seminar:</p>

<form action="edit" method="POST" id="form">
	<input type="hidden" name="sems_id" value="{{sems_id}}">
	<input type="hidden" name="sem_id" value="{{sem_id}}">
	<input type="text" name="title" value="{{title}}">
	<input type="text" name="description" value="{{description}}">
	<input type="submit" name="save" value="save">

	<div id="teacher_select"></div>
	
</form>


<button type="button" onclick="AddTeacher(teachers)">Add Teacher</button>

<script src="/js/scripts.js"></script>
<script>
  for (var i in selected_teachers){
    AddTeacher(teachers, selected_teachers[i][0]);
  }
</script>
