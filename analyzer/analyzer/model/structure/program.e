note
	description: "Summary description for {PROGRAM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROGRAM

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

feature -- Constructor
	make
		do
			create list.make
		end

feature -- Command
	add_class (cd: CLASS_DECLARATION)
		do
			list.extend (cd)
		end

end
