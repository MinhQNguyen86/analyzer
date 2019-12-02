note
	description: "Summary description for {QUERY_DECLARATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QUERY_DECLARATION

inherit
	ROUTINE_DECLARATION

create
	make

feature -- Commands
	accept (v: VISITOR)
		do
			v.visit_query_declaration (CURRENT)
		end
end
