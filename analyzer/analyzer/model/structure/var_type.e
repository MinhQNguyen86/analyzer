note
	description: "Summary description for {VAR_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VAR_TYPE

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
create
	make

feature -- Attributes
	type: STRING


feature -- Constructor
	make (t: STRING)
		-- can be int | boolean | void | *Name*
		do
			type := t
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
			
		end
end
