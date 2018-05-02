<form action="add" method="POST">
	<input type="text" name="title" value="Title">
	<input type="text" name="description" value="Description">
	<input type="submit" name="save" value="Add Seminar">
	<select name="teacher">
	%for teacher in teachers:
		<option value={{teacher[0]}}>{{teacher[1]}}</option>
	%end
	</select>
</form>