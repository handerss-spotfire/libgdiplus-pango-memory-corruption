using System.Drawing;
using System.Threading.Tasks;
using System.Collections.Generic;

var tasks = new List<Task>();

for (var i = 0; i < 1000; i++)
{
    tasks.Add(Task.Run(() =>
    {
        using (var bitmap = new Bitmap(100, 100))
        using (var g = Graphics.FromImage(bitmap))
        using (var font = new Font("Arial", 10))
        using (var f = new StringFormat())

        {
            f.Trimming = StringTrimming.EllipsisCharacter; // If this line is commented out, there will be no glib warnings.
            g.MeasureString("APA", font, new PointF(0, 0), f);
        }
    }));

}

Task.WaitAll(tasks.ToArray());
