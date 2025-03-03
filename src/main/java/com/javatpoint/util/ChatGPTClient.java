/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.javatpoint.util;

import okhttp3.*;
import org.json.JSONArray;
import org.json.JSONObject;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ChatGPTClient {
    private static final String API_URL = "https://api.openai.com/v1/chat/completions";
    private static final String API_KEY = "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";  // Substitua pela sua chave da OpenAI
    private static final int MAX_TOKENS = 8000; // Ajuste conforme necessário

    private List<JSONObject> contextHistory = new ArrayList<>();

    public String chatWithGPT(String userMessage) throws IOException {
        contextHistory.add(new JSONObject().put("role", "user").put("content", userMessage));
        StringBuilder fullResponse = new StringBuilder();
        
        while (true) {
            String partResponse = sendRequest();
            fullResponse.append(partResponse);

            // Se a resposta estiver incompleta, pede para continuar
            if (!isResponseIncomplete(partResponse)) {
                break;
            }

            contextHistory.add(new JSONObject().put("role", "assistant").put("content", partResponse));
            contextHistory.add(new JSONObject().put("role", "user").put("content", "Por favor, continue."));
        }

        return fullResponse.toString();
    }

    private String sendRequest() throws IOException {
        OkHttpClient client = new OkHttpClient();

        JSONObject requestBody = new JSONObject();
        requestBody.put("model", "gpt-4");
        requestBody.put("messages", new JSONArray(contextHistory));
        requestBody.put("max_tokens", 1024); // Ajuste conforme necessário

        Request request = new Request.Builder()
                .url(API_URL)
                .post(RequestBody.create(requestBody.toString(), MediaType.parse("application/json")))
                .addHeader("Authorization", "Bearer " + API_KEY)
                .build();

        Response response = client.newCall(request).execute();

        if (!response.isSuccessful()) {
            throw new IOException("Erro na requisição: " + response);
        }

        JSONObject responseBody = new JSONObject(response.body().string());
        String botResponse = responseBody.getJSONArray("choices").getJSONObject(0).getJSONObject("message").getString("content");

        contextHistory.add(new JSONObject().put("role", "assistant").put("content", botResponse));

        while (getTokenCount(contextHistory) > MAX_TOKENS) {
            contextHistory.remove(0); // Remove as mensagens mais antigas
        }

        return botResponse;
    }

    private boolean isResponseIncomplete(String response) {
        // Verifica se a resposta parece estar cortada
        return response.endsWith("...") || response.length() > 900; // Ajuste conforme necessário
    }

    private int getTokenCount(List<JSONObject> messages) {
        return messages.stream().mapToInt(msg -> msg.getString("content").split("\\s+").length).sum();
    }

    public static void main(String[] args) {
        ChatGPTClient chatGPTClient = new ChatGPTClient();
        try {
            String response = chatGPTClient.chatWithGPT("Explique a Teoria da Relatividade em detalhes.");
            System.out.println("ChatGPT: " + response);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

