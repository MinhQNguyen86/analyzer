note
	description: "Summary description for {INTEGER_CONSTANT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INTEGER_CONSTANT

inherit
	BASIC_EXP

create
	make

feature -- Attributes
	value: INTEGER

feature -- Constructor
	make (num: INTEGER)
		require
			num > 0
		do
			value := num
		end

feature -- Output
--	out: STRING
--		do
--			Result := value.out
--		end

feature -- Queries

	get_value: INTEGER
		do
			Result := value
		end
	
	accept(v: VISITOR)
		do
			v.visit_integer_constant (Current)
		end

invariant
	value > 0
end
