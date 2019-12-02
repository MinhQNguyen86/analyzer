note
	description: "Summary description for {VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	VISITOR

feature -- visit features

	visit_call_chain(v: CALL_CHAIN)
		deferred
		end

	visit_boolean_constant(v: BOOLEAN_CONSTANT)
		deferred
		end

	visit_integer_constant(v: INTEGER_CONSTANT)
		deferred
		end

	visit_current_exp(v: CURRENT_EXP)
		deferred
		end

	visit_nil_exp(v: NIL_EXP)
		deferred
		end

	visit_binary_add(v: BINARY_ADD)
		deferred
		end

	visit_binary_div(v: BINARY_DIV)
		deferred
		end

	visit_binary_mod(v: BINARY_MOD)
		deferred
		end

	visit_binary_mult(v: BINARY_MULT)
		deferred
		end

	visit_binary_sub(v: BINARY_SUB)
		deferred
		end

	visit_binary_and(v: BINARY_AND)
		deferred
		end

	visit_binary_or(v: BINARY_OR)
		deferred
		end

	visit_binary_eq(v: BINARY_EQ)
		deferred
		end

	visit_binary_gt(v: BINARY_GT)
		deferred
		end

	visit_binary_lt(v: BINARY_LT)
		deferred
		end

	visit_unary_log_neg(v: UNARY_LOG_NEG)
		deferred
		end

	visit_unary_num_neg(v: UNARY_NUM_NEG)
		deferred
		end

	visit_class_declaration(v: CLASS_DECLARATION)
		deferred
		end

	visit_attribute_declaration(v: ATTRIBUTE_DECLARATION)
		deferred
		end

	visit_query_declaration(v: QUERY_DECLARATION)
		deferred
		end

	visit_command_declaration(v: COMMAND_DECLARATION)
		deferred
		end

	visit_assignment(v: ASSIGNMENT)
		deferred
		end

end
