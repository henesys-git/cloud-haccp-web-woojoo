package utils;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

public class FormatTransformer {
	
	public static String toJson(List<?> list) {
		ObjectMapper objectMapper = new ObjectMapper();
		
		JsonNode listNode = objectMapper.valueToTree(list);
		
		JSONArray jsonArray = new JSONArray();
		
		try {
			jsonArray = new JSONArray(listNode.toString());
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		return jsonArray.toString();
	}
	
}
