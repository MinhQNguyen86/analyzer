note
	description: "Summary description for {PARAMETERS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PARAMETERS

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

create
	make

feature -- Attributes
	para: ARRAY[TUPLE[pn: STRING; pt: STRING]]

feature -- Constructor
	make (p: like para)
		do
			para := p
		end

feature -- Commands

feature -- Queries
	out : STRING
		do
			create Result.make_from_string ("  ")
			Result.append ("(")
			
			Result.append (")")
		end

end
