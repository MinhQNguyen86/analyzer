note
	description: "Summary description for {CURRENT_EXP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CURRENT_EXP

inherit
	NULL_EXP

create
	make

feature -- Constructor
	make
		do
			value := "?"
			parent := Current
		end

feature -- Commands
	accept(v: VISITOR)
		do
			v.visit_current_exp (Current)
		end
end
