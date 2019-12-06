<template lang="pug">
    Dialog
        div
            div
                v-icon(:name="icon")
</template>

<script>
import Dialog from "@/components/base/dialogs/Dialog";

export default {
    name: "InfoDialog",
    components: {
        Dialog
    },
    props: {
        icon: {
            type: String,
            default: "times"
        },
        text: {
            type: String,
            default: "1suqwwiuwq8127e893ue8392ur89u"
        }
    }
    
}
</script>