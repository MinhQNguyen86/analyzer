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
	
end
