<template lang="pug">
    div(style="padding: 48px 300px")
        div(v-if="error && needLogin")
            p 会话无效, 需要重新登录:(
            spacer(:height="24")
            button2(color="#123456", hover-color="#456789", :height="48", :width="200",
                @click="$router.replace('/')") 重新登录
        div(v-if="!error")
            div(style="display: inline-flex; align-items: center")
                img(src="../../assets/logo.png",
                    style="border-radius: 50%; box-shadow: 0 0 40px 0 #00000022; width: 96px; height: 96px; ")
                h2(style="padding: 0 32px;") {{ lastName + firstName }}

            spacer

            div
                button2(color="#123456", hover-color="#456789", :height="48", :width="200")
                    span(style="padding: 0 8px") 修改密码
                    v-icon(name="lock")
</template>

<script>
import Button2 from "@/components/base/button/Button2";
import Spacer from "@/components/base/layout/Spacer";

export default {
    name: "UserCenter",
    components: { Button2, Spacer },
    created: function () {
        let domain = this.global.domain;
        let prefix = this.global.prefix;


        this.axios.get(`http://${domain}/${prefix}users`).then((response) => {
            if (response.data.code === 0) {
                let data = response.data.data;
                this.firstName = data.userInfo.uFirstName;
                this.lastName = data.userInfo.uLastName;
                this.email = data.userInfo.uEmail;
            } else if (response.data.code === 2000) {
                this.error = true;
                this.needLogin = true;
            } else {
                this.error = true;
                this.needLogin = false;
                this.error = response.data.msg;
            }
        });
    },
    data: function () {
        return {
            error: false,
            errorMessage: "ERROR",
            needLogin: false,

            firstName: "",
            lastName: "",
            email: "",
        }
    }
}
</script>

<style scoped>

</style>