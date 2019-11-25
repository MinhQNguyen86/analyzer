note
	description: "Summary description for {EXPRESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EXPRESSION

feature -- Queries

	accept (v: VISITOR)
		deferred
		end

	parent: EXPRESSION
		attribute
			Result := create {CURRENT_EXP}.make
		end

	set_parent(e: EXPRESSION)
		do
			parent := e
		end

	get_parent: EXPRESSION
		do
			Result := parent
		end
end
