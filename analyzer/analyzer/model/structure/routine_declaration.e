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
		end
	GRAMMAR
		rename
			out as g_out
		select
			g_out
		end
	COMPOSITE[GRAMMAR]
		rename
			out as c_out
		end
create
	make

feature -- Attributes
	name: STRING

feature -- Constructor
	make (cn: STRING)
		do
			name := cn
			create list.make
		end

feature -- Commands
	add_attribute (attr: ATTRIBUTE_DECLARATION)
		do

		end

	add_routine (rout: ROUTINE_DECLARATION)
		do

		end

feature -- Queries
	out : STRING
		do
			create Result.make_from_string ("  ")
			Result.append ("System State: default model state ")
			Result.append ("(")
			Result.append (")")
		end
end
