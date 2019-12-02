note
	description: "Summary description for {BOOLEAN_CONSTANT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOOLEAN_CONSTANT

inherit
	BASIC_EXP

create
	make

feature -- Attributes
	value: BOOLEAN

feature -- Constructor
	make (b: BOOLEAN)
		do
			value := b
		end

feature -- Queries

	get_value: BOOLEAN
		do
			Result := value
		end

	accept(v: VISITOR)
		do
			v.visit_boolean_constant (Current)
		end
end
