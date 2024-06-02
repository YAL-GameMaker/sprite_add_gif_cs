using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Runtime.InteropServices;

namespace sprite_add_gif_cs {
    public class sprite_add_gif_cs {
        static Image gif;
        static FrameDimension dimension;

        [DllExport]
        public static unsafe string sprite_add_gif_cs_start(byte* buf, double _length, int* info) {
            var length = (int)_length;
            try {
                var stream = new UnmanagedMemoryStream(buf, length, length, FileAccess.Read);
                gif = Image.FromStream(stream);
                dimension = new FrameDimension(gif.FrameDimensionsList[0]);
                info[0] = gif.GetFrameCount(dimension);
                info[1] = gif.Width;
                info[2] = gif.Height;
                return "";
            } catch (Exception e) {
                return e.ToString();
            }
        }

        [DllExport]
        public static unsafe string sprite_add_gif_cs_get_frame(double _frame, byte* buf, double _length, int* delay) {
            var frame = (int)_frame;
            var length = (int)_length;

            gif.SelectActiveFrame(dimension, frame);
            var bitmap = new Bitmap(gif);
            var rect = new Rectangle(Point.Empty, bitmap.Size);
            var data = bitmap.LockBits(rect, ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);

            var width = data.Width;
            var rowSize = width * 4;
            var height = data.Height;
            var stride = data.Stride;
            var error = "";
            try {
                if (stride == rowSize) {
                    var size = stride * height;
                    Buffer.MemoryCopy((void*)data.Scan0, buf, length, size);
                } else {
                    for (int y = 0; y < height; y++) {
                        var src = data.Scan0 + y * stride;
                        var dst = buf + y * rowSize;
                        Buffer.MemoryCopy((void*)src, dst, rowSize, rowSize);
                    }
                }
            } catch (Exception e) {
                error = e.ToString();
			}
            bitmap.UnlockBits(data);

            //
            int i = 0;
            int till = (length >> 4) << 4;
            for (; i < till; i += 16) {
                byte tmp;
                //
                tmp = buf[i];
                buf[i] = buf[i + 2];
                buf[i + 2] = tmp;
                //
                tmp = buf[i + 4];
                buf[i + 4] = buf[i + 6];
                buf[i + 6] = tmp;
                //
                tmp = buf[i + 8];
                buf[i + 8] = buf[i + 10];
                buf[i + 10] = tmp;
                //
                tmp = buf[i + 12];
                buf[i + 12] = buf[i + 14];
                buf[i + 14] = tmp;
            }
            for (; i < length; i += 4) {
                var tmp = buf[i];
                buf[i] = buf[i + 2];
                buf[i + 2] = tmp;
			}

            // https://stackoverflow.com/a/3785231/5578773
            var item = gif.GetPropertyItem(0x5100);
            delay[0] = (item.Value[0] + item.Value[1] * 256);
            //
            return error;
		}
    }
}