note
	description: "Summary description for {PROGRAM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROGRAM

inherit
--	ANY
--		redefine
--			out
--		end	
	GRAMMAR
--		rename
--			out as g_out
--		select
--			g_out
--		end
	COMPOSITE[CLASS_DECLARATION]
--		rename
--			out as c_out
--		end

create
	make

feature -- Constructor
	make
		do
			create children.make
		end

feature -- Command
--	add_class (cd: CLASS_DECLARATION)
--		do
--			list.extend (cd)
--		end

-- add_child feature in parent (composite)

end
