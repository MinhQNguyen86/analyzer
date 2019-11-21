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


feature -- Queries
	out : STRING
		do
			create Result.make_from_string ("  ")
			Result.append(type)
		end
end
