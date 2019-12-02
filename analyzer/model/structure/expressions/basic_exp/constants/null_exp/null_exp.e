note
	description: "Summary description for {NULL_EXP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NULL_EXP

inherit
	BASIC_EXP

feature -- Attributes
	value : STRING

feature -- Queries
	get_value: STRING
		do
			Result := value
		end

end
