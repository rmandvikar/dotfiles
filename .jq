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
