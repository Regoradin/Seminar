<script src="/js/scripts.js"></script>

<script>
  var teachers = {{!teachers}};

  document.addEventListener("DOMContentLoaded", function(event){AddTeacher(teachers);});
</script>

<form action="add" method="POST">
	<input type="text" name="title" value="Title">
	<input type="text" name="description" value="Description">
	<input type="submit" name="save" value="Add Seminar">
	<div id="teacher_select"></div>
</form>

<form action = "/teacher">
	<input type="submit" value="Back">
</form>

