note
	description: "Summary description for {ATTRIBUTE_DECLARATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ATTRIBUTE_DECLARATION

inherit
	GRAMMAR
		rename
			out as g_out
		end
	ANY
		redefine
			out
		select
			out
		end

create
	make

feature -- Attributes
	name: STRING
	type: STRING

feature -- Constructor
	make (cn, t: STRING)
		do
			name := cn
			type := t
		end

feature -- Commands

feature -- Queries
		out : STRING
		do
			create Result.make_from_string ("  ")
			Result.append (type + " ")
			Result.append (name + ";%N")
		end
end
