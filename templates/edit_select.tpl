%for seminar in result:
	%id = seminar[0]
	%name = seminar[1]
	<form action="edit" method="POST">
		<input type="hidden" name="id" value = "{{id}}">
		<input type="submit" name= "sem_name" value = "{{name}}">
	</form>