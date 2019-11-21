note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature -- Attributes
	program: PROGRAM

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			create program.make
		end

feature -- model operations

	add_class(cn: STRING)
		do
			-- add class name to list
		end

	add_attribute(cn, fn, ft: STRING)
		do
			-- add to class 'cn' new attr 'fn' w/ type 'ft'
		end

	add_command(cn, fn: STRING; ps: ARRAY[TUPLE[pn, pt: STRING]])
		do
			-- add to class 'cn' new command 'fn' w/ list of
			-- parameters 'ps'. Each parameter is a tuple
			-- w/ parameter name 'pn' and type 'pt'
			-- 'pt' can be int/boolean/class_name
		end

	add_query(cn, fn, rt: STRING; ps: ARRAY[TUPLE[pn, pt: STRING]])
		do
			-- add to class 'cn' new query 'fn' w/ list of
			-- parameters 'ps' and return type 'rt'.
			-- Each parameter is a tuple
			-- w/ parameter name 'pn' and type 'pt'
			-- 'pt' can be int/boolean/class_name
		end

	add_assignment_instruction(cn, fn, n: STRING)
		do
			-- assign to variable named 'n' in routine 'fn'
			-- of class 'cn'. 'n' should be 'Result' (if query)
			-- or an attribute name in current class
		end


	default_update
			-- Perform update to the model state.
		do
		end

	reset
			-- Reset model state.
		do
			make
		end

feature -- queries
	out : STRING
		do
			create Result.make_from_string ("  ")
			Result.append ("System State: default model state ")
			Result.append ("(")
			Result.append (")")
		end

end




