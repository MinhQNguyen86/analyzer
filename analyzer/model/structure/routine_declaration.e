note
	description: "Summary description for {ROUTINE_DECLARATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROUTINE_DECLARATION

inherit
	ANY
		redefine
			out
		select
			out
		end
	GRAMMAR
		rename
			out as g_out
		end
	COMPOSITE[GRAMMAR]
		rename
			out as c_out
		end
create
	make

feature -- Attributes
	name: STRING
	type: STRING
	para: PARAMETERS


feature -- Constructor
	make (cn, t: STRING; p: ARRAY[TUPLE[STRING, STRING]])
		do
			name := cn
			type := t
			create children.make -- holds assigments*
			create para.make (p)
		end

feature -- Commands


feature -- Queries
	out : STRING
		do
			create Result.make_from_string ("  ")
			Result.append ("System State: default model state ")
			Result.append ("(")
			Result.append (")")
		end
end
