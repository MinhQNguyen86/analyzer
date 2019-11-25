note
	description: "Summary description for {NIL_EXP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NIL_EXP

inherit
	NULL_EXP

create
	make

feature -- Constructor
	make
		do
			value := "nil"
			parent := Current
			
		end

feature -- Output
--	out: STRING
--		do
--			Result := "nil"
--		end

feature -- Commands
	accept(v: VISITOR)
		do
			v.visit_nil_exp (Current)
		end

end
