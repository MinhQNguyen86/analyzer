note
	description: "Summary description for {LANGUAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LANGUAGE

feature -- Visitor

	accept (v: VISITOR)
		deferred
		end

feature -- Name
	name: STRING

feature -- Query
	get_name: STRING
		do
			Result := name
		end
end
