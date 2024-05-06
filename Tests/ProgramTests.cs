using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SampleTest.Tests
{
    public class ProgramTests
    {
        [Test]
        public void Add_WhenGivenTwoNumbers_ReturnsSum()
        {
            // Arrange
            int a = 3;
            int b = 5;

            // Act
            int result = Program.Add(a, b);

            // Assert
            Assert.Equals(8, result);
        }
    }
}