using System;

namespace AlloyDemoKit.Business
{
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    public class HideOnContentCreateAttribute : Attribute { }
}