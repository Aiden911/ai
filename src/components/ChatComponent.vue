<template>
  <div class="chat-widget">
    <!-- 聊天圖標 -->
    <div v-if="!isOpen" class="chat-icon" @click="toggleChat">
      <div class="icon">💬</div>
    </div>

    <!-- 聊天視窗 -->
    <transition name="slide-fade">
      <div v-if="isOpen" class="chat-container">
        <!-- 標題欄 -->
        <div class="chat-header">
          <span>AI 助理</span>
          <button class="close-button" @click="toggleChat">×</button>
        </div>

        <!-- 聊天內容 -->
        <div class="messages-container" ref="messagesContainer">
          <div
            v-for="(message, index) in messages"
            :key="index"
            :class="['message', message.type]"
          >
            <div class="message-content">
              <div class="avatar">
                {{ message.type === "user" ? "👤" : "🤖" }}
              </div>
              <div class="text">{{ message.content }}</div>
              <div class="time">{{ formatTime(message.timestamp) }}</div>
            </div>
          </div>
          <div v-if="isLoading" class="message bot">
            <div class="message-content">
              <div class="avatar">🤖</div>
              <div class="typing">...</div>
            </div>
          </div>
        </div>

        <div class="input-container">
          <input
            v-model="userInput"
            @keyup.enter="sendMessage"
            placeholder="請輸入您的問題..."
            :disabled="isLoading"
          />
          <button @click="sendMessage" :disabled="isLoading || !userInput.trim()">
            送出
          </button>
        </div>
      </div>
    </transition>
  </div>
</template>

<script>
import { ref, onMounted, nextTick } from "vue";

export default {
  name: "ChatComponent",
  setup() {
    const messages = ref([]);
    const userInput = ref("");
    const isLoading = ref(false);
    const messagesContainer = ref(null);
    const isOpen = ref(false);

    // API 相關設定
    /*
    const ANTHROPIC_API_KEY = "your-api-key";
    const API_URL = "https://api.anthropic.com/v1/messages";
    */

    const scrollToBottom = async () => {
      await nextTick();
      if (messagesContainer.value) {
        messagesContainer.value.scrollTop = 
          messagesContainer.value.scrollHeight;
      }
    };

    const formatTime = (timestamp) => {
      return new Date(timestamp).toLocaleTimeString();
    };

    const toggleChat = () => {
      isOpen.value = !isOpen.value;
      if (isOpen.value) {
        nextTick(() => {
          scrollToBottom();
        });
      }
    };

    const sendMessage = async () => {
      if (!userInput.value.trim() || isLoading.value) {
        return;
      }

      const userMessage = {
        content: userInput.value,
        type: "user",
        timestamp: new Date(),
      };

      messages.value.push(userMessage);
      const currentInput = userInput.value;
      userInput.value = "";
      isLoading.value = true;

      await scrollToBottom();

      // 模擬 API 回應
      setTimeout(() => {
        const mockResponse = `這是對「${currentInput}」的模擬回應。我是 AI 助理,很高興為您服務!`;
        
        messages.value.push({
          content: mockResponse,
          type: "bot",
          timestamp: new Date(),
        });
        
        isLoading.value = false;
        scrollToBottom();
      }, 1000);  // 延遲 1 秒來模擬 API 回應時間

      /*  API 呼叫相關程式碼
      try {
        const response = await fetch(API_URL, {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "x-api-key": ANTHROPIC_API_KEY,
            "anthropic-version": "2023-06-01",
          },
          body: JSON.stringify({
            messages: [{ role: "user", content: currentInput }],
            model: "claude-3-sonnet-20240229",
            max_tokens: 1000,
          }),
        });

        const data = await response.json();

        messages.value.push({
          content: data.content[0].text,
          type: "bot",
          timestamp: new Date(),
        });
      } catch (error) {
        messages.value.push({
          content: "抱歉，發生錯誤，請稍後再試。",
          type: "bot",
          timestamp: new Date(),
        });
        console.error("Error:", error);
      }
      */

      isLoading.value = false;
      await scrollToBottom();
    };

    onMounted(() => {
      messages.value.push({
        content: "您好！我是您的AI助理，很高興為您服務。",
        type: "bot",
        timestamp: new Date(),
      });
    });

    return {
      messages,
      userInput,
      isLoading,
      messagesContainer,
      sendMessage,
      formatTime,
      isOpen,
      toggleChat,
    };
  },
};
</script>

<style scoped>
.chat-widget {
  position: fixed;
  bottom: 20px;
  right: 20px;
  z-index: 1000;
}

.chat-icon {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  background: #007aff;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
  transition: transform 0.3s ease;
}

.chat-icon:hover {
  transform: scale(1.1);
}

.icon {
  font-size: 24px;
  color: white;
}

.chat-header {
  padding: 15px 20px;
  background: #007aff;
  color: white;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-radius: 8px 8px 0 0;
}

.close-button {
  background: none;
  border: none;
  color: white;
  font-size: 24px;
  cursor: pointer;
  padding: 0 5px;
}

.chat-container {
  position: fixed;
  bottom: 90px;
  right: 20px;
  width: 100%;
  max-width: 400px;
  height: 500px;
  margin: 0;
  border: 1px solid #ddd;
  border-radius: 8px;
  display: flex;
  flex-direction: column;
  background: white;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.messages-container {
  flex: 1;
  overflow-y: auto;
  padding: 20px;
  background: #f5f5f5;
}

.message {
  margin-bottom: 16px;
}

.message-content {
  display: flex;
  align-items: flex-start;
  gap: 8px;
}

.avatar {
  font-size: 24px;
  min-width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: white;
  border-radius: 50%;
}

.text {
  background: white;
  padding: 12px;
  border-radius: 12px;
  max-width: 70%;
  word-wrap: break-word;
}

.time {
  font-size: 12px;
  color: #666;
  margin-top: 4px;
}

.user .message-content {
  flex-direction: row-reverse;
}

.user .text {
  background: #007aff;
  color: white;
}

.typing {
  background: white;
  padding: 12px;
  border-radius: 12px;
  animation: typing 1s infinite;
}

.input-container {
  padding: 20px;
  background: white;
  border-top: 1px solid #ddd;
  display: flex;
  gap: 10px;
}

input {
  flex: 1;
  padding: 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
}

button {
  padding: 12px 24px;
  background: #007aff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

button:disabled {
  background: #ccc;
  cursor: not-allowed;
}

/* 轉場動畫 */
.slide-fade-enter-active {
  transition: all 0.3s ease-out;
}

.slide-fade-leave-active {
  transition: all 0.3s cubic-bezier(1, 0.5, 0.8, 1);
}

.slide-fade-enter-from,
.slide-fade-leave-to {
  transform: translateY(20px);
  opacity: 0;
}

@keyframes typing {
  0% {
    opacity: 0.3;
  }

  50% {
    opacity: 1;
  }

  100% {
    opacity: 0.3;
  }
}
</style>