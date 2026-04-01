#include <linux/module.h>
#include <linux/init.h>

static int __init techleef_init(void){
    printk(KERN_INFO "Hello from Techleef");
    return 0;
}

static void __exit techleef_exit(void){
    printk(KERN_INFO "Goodbye from techleef");
}

MODULE_DESCRIPTION("blavla");
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Tzechleef");
