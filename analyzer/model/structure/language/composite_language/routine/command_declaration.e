note
	description: "Summary description for {COMMAND_DECLARATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_DECLARATION

inherit
	ROUTINE_DECLARATION

create
	make

feature -- Commands
	accept (v: VISITOR)
		do
			v.visit_command_declaration (CURRENT)
		end

end
