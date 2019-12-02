note
	description: "Summary description for {PRETTY_PRINT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PRETTY_PRINT

inherit
	VISITOR

create
	make

feature -- Attributes
	msg : STRING

feature {NONE} -- Constructor
	make
		do
			create msg.make_empty
		end

feature -- Query
	get_msg: STRING
		do
			Result := msg
		end

feature -- Visitor pattern

	visit_binary_add(v: BINARY_ADD)
		do
			visit_binary_op(v)
		end

	visit_binary_div(v: BINARY_DIV)
		do
			visit_binary_op(v)
		end

	visit_binary_mod(v: BINARY_MOD)
		do
			visit_binary_op(v)
		end

	visit_binary_mult(v: BINARY_MULT)
		do
			visit_binary_op(v)
		end

	visit_binary_sub(v: BINARY_SUB)
		do
			visit_binary_op(v)
		end

	visit_binary_and(v: BINARY_AND)
		do
			visit_binary_op(v)
		end

	visit_binary_or(v: BINARY_OR)
		do
			visit_binary_op(v)
		end

	visit_binary_eq(v: BINARY_EQ)
		do
			visit_binary_op(v)
		end

	visit_binary_gt(v: BINARY_GT)
		do
			visit_binary_op(v)
		end

	visit_binary_lt(v: BINARY_LT)
--		local
--			pp1, pp2: PRETTY_PRINT
		do
--			create pp1.make
--			create pp2.make
--			msg.append ("(")
--			v.left.accept (pp1)
--			msg.append (pp1.get_msg)
--			msg.append (" " + v.get_value + " ")
--			v.right.accept (pp2)
--			msg.append (pp2.get_msg)
			visit_binary_op(v)
		end

	visit_binary_op(v: BINARY_OP)
		local
			pp1, pp2: PRETTY_PRINT
		do
			create pp1.make
			create pp2.make
			msg.append ("(")
			v.left.accept (pp1)
			msg.append (pp1.get_msg)
			msg.append (" " + v.get_value + " ")
			v.right.accept (pp2)
			msg.append (pp2.get_msg)
			msg.append (")")
		end

	visit_call_chain(v: CALL_CHAIN)
		do
			across
				v.get_chain.lower |..| v.get_chain.upper is s
			loop
				msg.append (v.get_chain[s])
				if s /= v.get_chain.upper then
					msg.append (".")
				end
			end
		end

	visit_boolean_constant(v: BOOLEAN_CONSTANT)
		do

			msg.append (v.get_value.out)

		end

	visit_integer_constant(v: INTEGER_CONSTANT)
		do

			msg.append (v.get_value.out)
		end

	visit_current_exp(v: CURRENT_EXP)
		do
			msg.append (v.get_value)
		end

	visit_nil_exp(v: NIL_EXP)
		do
			msg.append (v.get_value)
		end

	visit_unary_log_neg(v: UNARY_LOG_NEG)
--		local
--			pp: PRETTY_PRINT
		do
--			create pp.make
--			msg.append ("(")
--			msg.append (v.get_value + " ")
--			v.get_exp.accept (pp)
--			msg.append (pp.get_msg)
--			msg.append (")")
			visit_unary_op(v)
		end

	visit_unary_num_neg(v: UNARY_NUM_NEG)
--		local
--			pp: PRETTY_PRINT
		do
--			create pp.make
--			msg.append ("(")
--			msg.append (v.get_value + " ")
--			v.get_exp.accept (pp)
--			msg.append (pp.get_msg)
--			msg.append (")")
			visit_unary_op(v)
		end

	visit_unary_op (v: UNARY_OP)
		local
			pp: PRETTY_PRINT
		do
			create pp.make
			msg.append ("(")
			msg.append (v.get_value + " ")
			v.get_exp.accept (pp)
			msg.append (pp.get_msg)
			msg.append (")")
		end

	visit_class_declaration(v: CLASS_DECLARATION)
		local
			pp : PRETTY_PRINT
		do
			msg.append ("  class " + v.get_name + " {%N")
			across
				v.get_children is l -- language
			loop
				create pp.make
				l.accept (pp)
				msg.append ("    " + pp.get_msg)
			end
			msg.append ("  }")
		end

	visit_attribute_declaration(v: ATTRIBUTE_DECLARATION)
		local
			type: STRING
		do
			create type.make_empty
			if v.get_type ~ "INTEGER" then
				type := "int"
			elseif v.get_type ~ "BOOLEAN" then
				type := "bool"
			else
				type := v.get_type
			end
			msg.append (type + " " + v.get_name + ";%N")
		end

	visit_query_declaration(v: QUERY_DECLARATION)
		local
			pp: PRETTY_PRINT
			type: STRING
		do
			create type.make_empty
			if v.get_type ~ "INTEGER" then
				type := "int"
			elseif v.get_type ~ "BOOLEAN" then
				type := "bool"
			else
				type := v.get_type
			end
			msg.append (type + " " + v.get_name)
			msg.append ("(")

			if not v.get_para.is_empty then
				across
					v.get_para.lower |..| v.get_para.upper is n -- tup[string, string]
				loop
					-- check name, type para

--					if attached {STRING} ((v.get_para[n])[1]) as t_1 and attached {STRING} ((v.get_para[n])[2]) as t_2 then
						-- add type
					if v.get_para[n].pt ~ "INTEGER" then
						msg.append ("int ")
					elseif v.get_para[n].pt ~ "BOOLEAN" then
						msg.append ("bool ")
					else
						msg.append (v.get_para[n].pt + " ")
					end
					-- add name
					msg.append (v.get_para[n].pn)
--					end
					-- add ,
					if n /= v.get_para.upper then
						msg.append(", ")
					end
				end -- end of loop
			end -- end of para

			msg.append (") {%N")

			-- set return_type Result = default_value
			msg.append ("      ")
			if v.get_type ~ "INTEGER" then
				msg.append ("int Result = 0;%N")
			elseif v.get_type ~ "BOOLEAN" then
				msg.append ("bool Result = false;%N")
			else
				msg.append (v.get_type + " Result = null;%N")
			end

			-- get children LL[ASSIGNMENT] * get the assignments		
			across
				v.get_children is a
			loop
				create pp.make
				a.accept (pp)
				msg.append ("      " + pp.get_msg + "%N")
			end

			-- return Result
			msg.append ("      return Result;%N")
			msg.append("    }%N")
		end

	visit_command_declaration(v: COMMAND_DECLARATION)
		local
			pp: PRETTY_PRINT
			type: STRING
		do
			create type.make_empty
			if v.get_type ~ "INTEGER" then
				type := "int"
			elseif v.get_type ~ "BOOLEAN" then
				type := "bool"
			else
				type := v.get_type
			end
			msg.append (type + " " + v.get_name)
			msg.append ("(")

			if not v.get_para.is_empty then
				across
					v.get_para.lower |..| v.get_para.upper is n -- tup[string, string]
				loop
					-- check name, type para
					-- add type
					if v.get_para[n].pt ~ "INTEGER" then
						msg.append ("int ")
					elseif v.get_para[n].pt ~ "BOOLEAN" then
						msg.append ("bool ")
					else
						msg.append (v.get_para[n].pt + " ")
					end
					-- add name
					msg.append (v.get_para[n].pn)

					-- add ,
					if n /= v.get_para.upper then
						msg.append(", ")
					end
				end -- end of loop
			end -- end of para

			msg.append (") {%N")
			-- get children LL[ASSIGNMENT]
			across
				v.get_children is a
			loop
				create pp.make
				a.accept (pp)
				msg.append ("      " + pp.get_msg + "%N")
			end
			msg.append("    }%N")
		end

	visit_assignment(v: ASSIGNMENT)
		local
			pp: PRETTY_PRINT
		do
			create pp.make
			msg.append (v.get_name + " = ")
			v.get_expression.accept (pp)
			msg.append (pp.get_msg + ";")
		end
end
