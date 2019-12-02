note
	description: "Summary description for {TYPE_CHECKER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_CHECKER

inherit
	VISITOR

create
	make

feature -- Attributes
	type: STRING -- INTEGER, BOOLEAN, CLASS_TYPE
	type_correct: BOOLEAN
	program: LINKED_LIST[CLASS_DECLARATION]
	context_class: CLASS_DECLARATION
	context_routine: ROUTINE_DECLARATION

feature -- constructor
	make (p: LINKED_LIST[CLASS_DECLARATION]; cc: CLASS_DECLARATION; rc: ROUTINE_DECLARATION)
		do
			create type.make_empty
			type_correct := True
			program := p
			context_class := cc
			context_routine := rc
		end

feature -- visitor

	visit_call_chain(v: CALL_CHAIN)
		local
			a: ARRAY[STRING]
		do
			a := v.get_chain

			-- check 1st element if ~ Result, then find type of current Routine



			-- check if 1st element is in 'context_class'
			-- either in attributes or in parameters
			-- first element is only one that can be in attribute or parameters

			across
				a.lower |..| a.upper is i
			loop
				--  if type_correct then try to find, else not type correct already, no need to look
				if type_correct then
					-- Check attributes for same name
					across
						context_class.get_attr is l_a  -- ATTR_DECLARATION
					loop
						if a[i] ~ l_a.get_name then
							-- type is type of the attribute var
							type := l_a.get_type
							-- try to find class_name with same name as attr type
							if type ~ "INTEGER" then
								type_correct := True
							elseif type ~ "BOOLEAN" then
								type_correct := True
							end
						end
					end -- end of attribute loop

					-- if a[1], then check if it's Result or check parameters
					if i = 1 and type.is_empty then
						-- check parameters/Result
						if a[i] ~ "Result" then
							type := context_routine.get_type
						else
							across
								context_routine.get_para_names.lower |..| context_routine.get_para_names.upper
									is j
							loop
								if context_routine.get_para_names[j] ~ a[i] then
									type := context_routine.get_para_type (j)
								end
							end
						end
					end

					-- if type_empty => both attributes and parameters (if i = 1)
					-- have been checked so type_correct is False
					if type.is_empty then
						type_correct := False
					end

					-- if call_chain is not done, and type is int or bool, then false
					if i /~ a.upper and (type ~ "INTEGER" or type ~ "BOOLEAN") then
						type_correct := False
					end

					-- set context class
					if type_correct then
						across
							program is cd
						loop
							if cd.get_name ~ type then
								context_class := cd
							end
						end
					end
				
				end -- if type correct
			end -- end of b.a.c.b loop



-- 1) Loop over ARRAY[STRING], a[i]. b.a.c.b
-- 1a) if type correct, then..
-- 2) Check if a[i] is in the current class' attribute list by comparing names.
-- 2a) if it's not set type_correct to False; this will make sure it wont continue
-- 2b) if it is, set type to the attribute's element type. type := attr.get_type : STRING
-- 3) if attr_type is "INTEGER" or "BOOLEAN" check if i is end of ARRAY[STRING] list.
-- if not, then type_correct := False
--


		end -- do

	visit_boolean_constant(v: BOOLEAN_CONSTANT)
		do
			type := "BOOLEAN"
			type_correct := True
		end

	visit_integer_constant(v: INTEGER_CONSTANT)
		do
			type := "INTEGER"
			type_correct := True
		end

	visit_current_exp(v: CURRENT_EXP)
		do
			type_correct := False
		end

	visit_nil_exp(v: NIL_EXP)
		do
			type_correct := False
		end

	visit_binary_int_op (v: BINARY_OP)
		local
			t1, t2: TYPE_CHECKER
		do
			create t1.make (program, context_class, context_routine)
			create t2.make (program, context_class, context_routine)
			v.left.accept (t1)
			v.right.accept (t2)
			type := "INTEGER"
			type_correct := (t1.type ~ "INTEGER") and (t2.type ~ "INTEGER") and (t1.type_correct)
				and (t2.type_correct)
		end

	visit_binary_log_op (v: BINARY_OP)
		local
			t1, t2: TYPE_CHECKER
		do
			create t1.make (program, context_class, context_routine)
			create t2.make (program, context_class, context_routine)
			v.left.accept (t1)
			v.right.accept (t2)
			type := "BOOLEAN"
			type_correct := (t1.type ~ "BOOLEAN") and (t2.type ~ "BOOLEAN") and (t1.type_correct)
				and (t2.type_correct)
		end

	visit_binary_add(v: BINARY_ADD)
		do
			visit_binary_int_op (v)
		end

	visit_binary_div(v: BINARY_DIV)
		do
			visit_binary_int_op (v)
		end

	visit_binary_mod(v: BINARY_MOD)
		do
			visit_binary_int_op (v)
		end

	visit_binary_mult(v: BINARY_MULT)
		do
			visit_binary_int_op (v)
		end

	visit_binary_sub(v: BINARY_SUB)
		do
			visit_binary_int_op (v)
		end

	visit_binary_and(v: BINARY_AND)
		do
			visit_binary_log_op (v)
		end

	visit_binary_or(v: BINARY_OR)
		do
			visit_binary_log_op (v)
		end

	visit_binary_eq(v: BINARY_EQ)
		local
			t1, t2: TYPE_CHECKER
		do
			type := "BOOLEAN"
			create t1.make (program, context_class, context_routine)
			create t2.make (program, context_class, context_routine)

			v.left.accept (t1)
			v.right.accept (t2)

			if t1.type ~ "INTEGER" then
--				v.right.accept (t2)
				type_correct := (t2.type ~ "INTEGER") and (t1.type_correct) and (t2.type_correct)
			elseif t1.type ~ "BOOLEAN" then
				type_correct := (t2.type ~ "BOOLEAN") and (t1.type_correct) and (t2.type_correct)
			end
		end

	visit_binary_gt(v: BINARY_GT)
		local
			t1, t2: TYPE_CHECKER
		do
			create t1.make (program, context_class, context_routine)
			create t2.make (program, context_class, context_routine)
			v.left.accept (t1)
			v.right.accept (t2)
			type := "BOOLEAN"
			type_correct := (t1.type ~ "INTEGER") and (t2.type ~ "INTEGER") and (t1.type_correct)
				and (t2.type_correct)
		end

	visit_binary_lt(v: BINARY_LT)
		local
			t1, t2: TYPE_CHECKER
		do
			create t1.make (program, context_class, context_routine)
			create t2.make (program, context_class, context_routine)
			v.left.accept (t1)
			v.right.accept (t2)
			type := "BOOLEAN"
			type_correct := (t1.type ~ "INTEGER") and (t2.type ~ "INTEGER") and (t1.type_correct)
				and (t2.type_correct)
		end

	visit_unary_log_neg(v: UNARY_LOG_NEG)
		local
			t: TYPE_CHECKER
		do
			create t.make (program, context_class, context_routine)
			v.get_exp.accept (t)
			type := "BOOLEAN"
			type_correct := t.type ~ "BOOLEAN" and t.type_correct
		end

	visit_unary_num_neg(v: UNARY_NUM_NEG)
		local
			t: TYPE_CHECKER
		do
			create t.make (program, context_class, context_routine)
			v.get_exp.accept (t)
			type := "INTEGER"
			type_correct := t.type ~ "INTEGER" and t.type_correct
		end

	visit_class_declaration(v: CLASS_DECLARATION)
		do
		end

	visit_attribute_declaration(v: ATTRIBUTE_DECLARATION)
		do
		end

	visit_query_declaration(v: QUERY_DECLARATION)
		do
		end

	visit_command_declaration(v: COMMAND_DECLARATION)
		do
		end

	visit_assignment(v: ASSIGNMENT)
		do
		end
end
