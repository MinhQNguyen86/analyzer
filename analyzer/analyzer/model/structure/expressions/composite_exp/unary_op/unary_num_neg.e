note
	description: "Summary description for {UNARY_NUM_NEG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UNARY_NUM_NEG

inherit
	UNARY_OP

create
	make

feature -- Attributes
	value: STRING = "-"

feature -- Output
--	out: STRING
--		do
--			Result := "(- " + get_exp.out + ")"
--		end

feature -- Queries

	accept(v: VISITOR)
		do
			v.visit_unary_num_neg (Current)
		end

end
