# jq functions

# return value only if not null (update only)
def replace(value):
	if . == null then null else value end;

# remove nulls
def denull:
	del(.[] | nulls);

# remove placeholder
def remove_placeholders:
	[
		. | to_entries[] |
		select(("<" + (.key | ascii_upcase) + ">") != .value)
	] | from_entries;

def case_mod_inner(case_mod_function):
	walk(
		if type == "object" then
			with_entries(.key |= (.[0:1] | case_mod_function) + .[1:])
		else
			.
		end
	);

# camelize keys
def camelize:
	case_mod_inner(ascii_downcase);

# pascalize keys
def pascalize:
	case_mod_inner(ascii_upcase);
