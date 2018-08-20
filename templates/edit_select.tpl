%for result in results:
%id = result[0]
%name = result[1]

	<form action="seminar" method="POST">
		<input type="hidden" name="sems_id" value = {{id}}>
		<input type="submit" name= "sem_name" value = "{{name}}">
	</form>
%end

<form action="/teacher" method="GET">
	<input type="submit" value="Back">
</form>
