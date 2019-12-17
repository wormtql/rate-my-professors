<template lang="pug">
    Dialog
        div(style="background: white; border-radius: 8px; padding: 16px; display: flex; align-item: center;")
            div(style="display: inline-flex; justify-content: center; align-items: center;")
                v-icon(:name="icon" :style="{color: iconColor}")
            p(style="display: inline-block; padding: 0 0 0 16px;") {{ text }}
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
            default: "information"
        },
        iconColor: {
            type: String,
            default: "black"
        }
    }
    
}
</script>