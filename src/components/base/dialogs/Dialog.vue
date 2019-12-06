<template lang="pug">
    div(:style="rootStyle")
        slot
</template>

<script>
export default {
    name: "Dialog",
    props: {
        background: {
            type: String,
            default: "#00000022",
        }
    },
    computed: {
        rootStyle: function () {
            return {
                background: this.background,
                display: "flex",
                zIndex: "10000",
                alignItems: "center",
                justifyContent: "center",
                position: "absolute",
                left: "0",
                top: "0",
                width: "100vw",
                height: "100vh",
            }
        }
    }
}
</script>

<style scoped>

</style>