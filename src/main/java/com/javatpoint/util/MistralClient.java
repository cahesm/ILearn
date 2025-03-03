
package com.javatpoint.util;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.javatpoint.model.Question;
import okhttp3.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import com.fasterxml.jackson.core.type.TypeReference;

public class MistralClient {
    private static final String API_URL = "https://api.mistral.ai/v1/chat/completions";
    private static final String API_KEY = "fgsLTd2jDaICMsUDOcR1Y3YTFNAPlgse"; // Substitua pela sua chave

    private final OkHttpClient client;
    private final Gson gson;
    private final List<Message> messages;

    public MistralClient() {
        this.client = new OkHttpClient();
        this.gson = new Gson();
        this.messages = new ArrayList<>();

        // Mensagem inicial do sistema
        messages.add(new Message("system", "Você é um assistente útil."));
    }

    public String chat(String userInput) throws IOException {
        
        userInput = "Faça um explanação extensa sobre os seguintes tópicos:" + userInput+". Quero somente a resposta, de preferência separe a resposta entre tópicos , formate o conteúdo em html e numere os tópicos. Não gere formatação para o body do html.";
                
        StringBuilder result = new StringBuilder("");
        messages.add(new Message("user", userInput));
        ChatRequest request = new ChatRequest("mistral-small-latest", messages, true);

        String jsonRequest = gson.toJson(request);
        RequestBody body = RequestBody.create(jsonRequest, MediaType.get("application/json"));

        Request httpRequest = new Request.Builder()
                .url(API_URL)
                .addHeader("Authorization", "Bearer " + API_KEY)
                .addHeader("Accept", "application/json")
                .post(body)
                .build();

        try (Response response = client.newCall(httpRequest).execute()) 
        {

            if (response.body() == null) 
            {
                throw new IOException("Resposta vazia da API");
            }

            ObjectMapper objectMapper = new ObjectMapper();
            StringBuilder fullResponse = new StringBuilder();

            // Converte a resposta do stream diretamente em uma String
            String responseBody = response.body().string();
    
            // Processa cada linha separadamente
            for (String line : responseBody.split("\n")) 
            {
                if (!line.startsWith("data: ")) continue; // Ignora linhas vazias ou sem "data:"

                String jsonString = line.substring(6).trim(); // Remove "data: " do início
                try 
                {
                    JsonNode jsonNode = objectMapper.readTree(jsonString);
                    JsonNode choices = jsonNode.get("choices");

                    if (choices != null && choices.isArray()) {
                        for (JsonNode choice : choices) {
                            JsonNode delta = choice.get("delta");
                            if (delta != null && delta.has("content")) {
                                String content = delta.get("content").asText();
                                //System.out.print(content); // Exibe em tempo real
                                fullResponse.append(content);
                        }
                    }
                    }
                } 
                catch (Exception e) {
                    System.err.println("Erro ao processar JSON: " + e.getMessage());
                }
            }
        
            result.append( fullResponse.toString());
            messages.add(new Message("assistant", fullResponse.toString()));
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        
        return result.toString().replaceAll("```html", "").replaceAll("```", "");
    }
    
    public List<Question> generateQuestions(String content) throws IOException {
        // Define um prompt para gerar 10 perguntas objetivas baseadas no conteúdo
        String prompt = "Baseado no seguinte conteúdo, gere 10 perguntas objetivas de múltipla escolha. "
                + "Cada pergunta deve ter 5 opções de resposta, somente pode ter uma opção verdadeira e correta. Indicar a resposta correta e uma explicação para ela. "
                + "As respostas não podem se repetir e a opção correta deve variar entre as 5 alternativas. Retorne no formato JSON. \"question\": \"Qual é a capital da França?\",\n" +
"        \"answers\": [\n" +
"            { \"answer\": \"Paris\", \"isCorrect\": true|false },\n" +
"            { \"answer\": \"Londres\", \"isCorrect\": true|false },\n" +
"            { \"answer\": \"Berlim\", \"isCorrect\": true|false },\n" +
"            { \"answer\": \"Roma\", \"isCorrect\": true|false },\n" +
"            { \"answer\": \"Madri\", \"isCorrect\": true|false }\n" +
"        ],\n" +
"        \"answer\": \"Paris é a capital da França.\" Conteúdo:\n" + content;

        StringBuilder result = new StringBuilder("");
        
        messages.add(new Message("user", prompt));
        ChatRequest request = new ChatRequest("mistral-small-latest", messages, true);

        String jsonRequest = gson.toJson(request);
        RequestBody body = RequestBody.create(jsonRequest, MediaType.get("application/json"));

        Request httpRequest = new Request.Builder()
                .url(API_URL)
                .addHeader("Authorization", "Bearer " + API_KEY)
                .addHeader("Accept", "application/json")
                .post(body)
                .build();

        try (Response response = client.newCall(httpRequest).execute()) {
            if (response.body() == null) {
                throw new IOException("Resposta vazia da API");
            }

            ObjectMapper objectMapper = new ObjectMapper();
            StringBuilder fullResponse = new StringBuilder();

            // Converte a resposta do stream diretamente em uma String
            String responseBody = response.body().string();
    
            // Processa cada linha separadamente
            for (String line : responseBody.split("\n")) 
            {
                if (!line.startsWith("data: ")) continue; // Ignora linhas vazias ou sem "data:"

                String jsonString = line.substring(6).trim(); // Remove "data: " do início
                try 
                {
                    JsonNode jsonNode = objectMapper.readTree(jsonString);
                    JsonNode choices = jsonNode.get("choices");

                    if (choices != null && choices.isArray()) {
                        for (JsonNode choice : choices) {
                            JsonNode delta = choice.get("delta");
                            if (delta != null && delta.has("content")) {
                                String c = delta.get("content").asText();
                                //System.out.print(content); // Exibe em tempo real
                                fullResponse.append(c);
                        }
                    }
                    }
                } 
                catch (Exception e) {
                    System.err.println("Erro ao processar JSON: " + e.getMessage());
                }
            }
        
            result.append( fullResponse.toString()); // Retorna diretamente o JSON gerado
        }
     
        String jsonString = result.toString().replaceAll("```json", "").replaceAll("```", "");
        
        ObjectMapper objectMapper = new ObjectMapper();
        List<Question> questions = objectMapper.readValue(jsonString, new TypeReference<List<Question>>() {});
//
//            // Exibe as perguntas
//            for (Question q : questions) {
//                System.out.println(q);
//            }
        
        //return result.toString().replaceAll("```json", "").replaceAll("```", "");
        return questions;
    }

    public static void main(String[] args) {
        MistralClient client = new MistralClient();

        // Lista de perguntas a serem enviadas automaticamente
        String[] perguntas = {
            "Explique programação funcional em Java.",
            "O que são Streams e Optionals no Java?",
            "Como melhorar a performance ao trabalhar com grandes volumes de dados em Java?"
        };

        try {
            for (String pergunta : perguntas) {
                System.out.println("Você: " + pergunta);
                client.chat(pergunta);
                Thread.sleep(1000); // Pequena pausa para evitar sobrecarga
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }
    
    private class Message {
    private String role;
    private String content;

    public Message(String role, String content) {
        this.role = role;
        this.content = content;
    }

    public String getRole() {
        return role;
    }

    public String getContent() {
        return content;
    }
}




private class ChatRequest {
    private String model;
    private List<Message> messages;
    private boolean stream;

    public ChatRequest(String model, List<Message> messages, boolean stream) {
        this.model = model;
        this.messages = messages;
        this.stream = stream;
    }
}
}
