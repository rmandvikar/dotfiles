# jq functions

# round decimal to precision
def round(precision):
	. * pow(10; precision) | round / pow(10; precision);

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

# downcase keys
def downcase:
	with_entries(.key |= ascii_downcase);

# upcase keys
def upcase:
	with_entries(.key |= ascii_upcase);

# camelize keys
def camelize:
	case_mod_inner(ascii_downcase);

# pascalize keys
def pascalize:
	case_mod_inner(ascii_upcase);

# ref: https://stackoverflow.com/a/34282594/58678
def toxsv(transform_function):
	if length == 0 then empty
	else
		(.[0] | keys_unsorted) as $keys
		| (map(keys) | add | unique) as $allkeys
		| ($keys + ($allkeys - $keys)) as $cols
		| ($cols, (.[] as $row | $cols | map($row[.])))
		| transform_function
	end;

# csv
def tocsv:
	toxsv(@csv);

# tsv
def totsv:
	toxsv(@tsv);

# unflatten
# see https://stackoverflow.com/questions/57154970/how-to-get-inverse-operation-of-flatten-for-objects-using-jq/57155523#57155523
def un_flatten(delim):
	reduce to_entries[] as $kv ({}; setpath($kv.key|split(delim); $kv.value));

def unflatten:
	un_flatten(".");

def unflatten(delim):
	un_flatten(delim);

def beautify_jwt:
	. as $jwt |
	# jwt
	try(
		$jwt | sub("(?<header>.+)\\.(?<payload>.+)\\.(?<signature>.*)"; "\(.header)") | @base64d | fromjson as $header |
		$jwt | sub("(?<header>.+)\\.(?<payload>.+)\\.(?<signature>.*)"; "\(.payload)") | @base64d | fromjson as $payload |
		$jwt | sub("(?<header>.+)\\.(?<payload>.+)\\.(?<signature>.*)"; "\(.signature)") as $signature |
		{
		  "header": $header,
		  "payload": $payload,
		  "signature": $signature,
		})
	catch error;

def beautify_authorization_header:
	if . | startswith("Bearer") then
		. as $authorization |
		# Bearer jwt
		try(
			$authorization | sub("(?<scheme>Bearer) (?<jwt>.+)"; "\(.scheme)") as $scheme |
			$authorization | sub("(?<scheme>Bearer) (?<jwt>.+)"; "\(.jwt)") | beautify_jwt as $jwt |
			{
			  "scheme": $scheme,
			  "jwt": $jwt,
			})
		catch error
	else
		.
	end;

def beautify_obfuscated_authorization_header:
	if . | startswith("Bearer") then
		. as $authorization |
		# Bearer obfuscated jwt
		try(
			$authorization | sub("(?<scheme>Bearer) (?<header>\\{.+\\})\\.(?<payload>\\{.+\\})\\.(?<signature>.*)"; "\(.scheme)") as $scheme |
			$authorization | sub("(?<scheme>Bearer) (?<header>\\{.+\\})\\.(?<payload>\\{.+\\})\\.(?<signature>.*)"; "\(.header)") | fromjson as $header |
			$authorization | sub("(?<scheme>Bearer) (?<header>\\{.+\\})\\.(?<payload>\\{.+\\})\\.(?<signature>.*)"; "\(.payload)") | fromjson as $payload |
			$authorization | sub("(?<scheme>Bearer) (?<header>\\{.+\\})\\.(?<payload>\\{.+\\})\\.(?<signature>.*)"; "\(.signature)") as $signature |
			{
			  "scheme": $scheme,
			  "jwt": {
			    "header": $header,
			    "payload": $payload,
			    "signature": $signature,
			  },
			})
		catch error
	else
		.
	end;
