%for i in range(len(sems_ids)):
	%id = sems_ids[i]
	%name = seminars[i][0]

	<form action="edit" method="POST">
		<input type="hidden" name="sems_id" value = {{id}}>
		<input type="submit" name= "sem_name" value = "{{name}}">
	</form>
%end