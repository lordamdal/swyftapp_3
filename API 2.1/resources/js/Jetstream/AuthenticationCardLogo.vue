<template>
    <Link :href="'/'" :class="'flex justify-center h-16 '">
        <img class="img-fluid rounded-normal" :src="'/images/logo.png'" alt="logo"/>
    </Link>
</template>

<script>
    import { defineComponent } from 'vue'
    import { Link } from '@inertiajs/inertia-vue3';

    export default defineComponent({
        components: {
            Link,
        },
    })
</script>
