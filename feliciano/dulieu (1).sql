CREATE DATABASE DTPBook
GO
USE DTPBook
GO


CREATE TABLE NguoiDung(
IDND INT PRIMARY KEY IDENTITY,
TenDN VARCHAR(30) UNIQUE,
MatKhau VARCHAR(30) ,
Ten NVARCHAR(40),
GioiTinh BIT,
NgaySinh DATE,
DiaChi NVARCHAR(50),
Phone NVARCHAR(11)
)
GO

CREATE TABLE Sach(
TenSach NVARCHAR(100),
IDSach VARCHAR(5) PRIMARY KEY ,
MoTa NTEXT,
Gia MONEY,
NhaXB NVARCHAR(50),
TacGia NVARCHAR(50),
NgayXB VARCHAR(10),
NgayUp DATE DEFAULT GETDATE(),
SoLuong INT,
SoAnh INT
)
GO

CREATE TABLE TheLoai(
IDLoai INT PRIMARY KEY IDENTITY,
Name NVARCHAR(50)
)
GO

CREATE TABLE LoaiSach(
IDSach VARCHAR(5),
IDLoai INT,
FOREIGN KEY (IDLoai) REFERENCES TheLoai(IDLoai),
FOREIGN KEY (IDSach) REFERENCES Sach(IDSach)
)
GO

CREATE TABLE LichSuMua(
MaDonHang INT PRIMARY KEY IDENTITY,
IDND INT,
TongTien MONEY,
NgayMua DATE ,
TrangThai NVARCHAR(30) DEFAULT N'Chờ Xử Lý'
)
GO

CREATE TABLE SachDaMua(
IDSach VARCHAR(5),
MaDonHang INT,
SoLuong INT ,

)
CREATE TABLE GioHang(
    IDND INT ,
    IDSach VARCHAR(5),
    SoLuong INT CHECK(SoLuong > 0),
  PRIMARY KEY(IDND,IDSach)
)
GO

CREATE TABLE QuanTri(
IDND INT PRIMARY KEY,
CONSTRAINT FK_IDNDQT FOREIGN KEY(IDND) REFERENCES NguoiDung(IDND) ON DELETE CASCADE
)

ALTER TABLE SachDaMua ADD CONSTRAINT FK_Madonhang
FOREIGN KEY(MaDonHang)
REFERENCES LichSuMua(MaDonHang)
ON DELETE NO ACTION

ALTER TABLE LichSuMua ADD CONSTRAINT FK_IDNDmua
FOREIGN KEY(IDND)
REFERENCES NguoiDung(IDND)
ON DELETE CASCADE

ALTER TABLE SachDaMua ADD CONSTRAINT FK_Sachmua
FOREIGN KEY(IDSach)
REFERENCES Sach(IDSach)
ON DELETE NO ACTION 

ALTER TABLE GioHang ADD CONSTRAINT FK_IDND
FOREIGN KEY(IDND)
REFERENCES NguoiDung(IDND)
ON DELETE CASCADE

ALTER TABLE GioHang ADD CONSTRAINT FK_Sach
FOREIGN KEY (IDSach) REFERENCES Sach(IDSach)
ON DELETE CASCADE

INSERT INTO NguoiDung 
VALUES ('duong6736','duong5799',N'Hồ Khánh Dương',0,'19990705',N'Tân Kỳ, Nghệ An','0967721773'),
('do6716','do20173009',N'Lê Đức Đô',0,'19990930',N'Thường Tín, Hà Nội','0967731753'),
('thao878','thao2409',N'Đỗ Thị Hồng Thảo',1,'19990924',N'Hà Nam','0967751553'),
('phuong6848','phuong0408',N'Nguyễn Thị Thu Phương',1,'19990804',N'Hà Nội','0967778954')
GO


INSERT INTO Sach(TenSach, IDSach, MoTa, Gia, NhaXB, TacGia, NgayXB,SoLuong,NgayUp,SoAnh)
VALUES (N'Bố Già','S001',N'Bố Già (Ấn Bản Kỉ Niệm Năm Mươi Năm Xuất Bản Lần Đầu)\n
Thế giới ngầm được phản ánh trong tiểu thuyết Bố Già là sự gặp gỡ giữa một bên là ý chí cương cường và nền tảng gia tộc chặt chẽ theo truyền thống mafia xứ Sicily với một bên là xã hội Mỹ nhập nhằng đen trắng, mảnh đất màu mỡ cho những cơ hội làm ăn bất chính hứa hẹn những món lợi kếch xù. Trong thế giới ấy, hình tượng Bố Già được tác giả dày công khắc họa đã trở thành bức chân dung bất hủ trong lòng người đọc. Từ một kẻ nhập cư tay trắng đến ông trùm tột đỉnh quyền uy, Don Vito Corleone là con rắn hổ mang thâm trầm, nguy hiểm khiến kẻ thù phải kiềng nể, e dè, nhưng cũng được bạn bè, thân quyến xem như một đấng toàn năng đầy nghĩa khí. Nhân vật trung tâm ấy đồng thời cũng là hiện thân của một pho triết lí rất “đời” được nhào nặn từ vốn sống của hàng chục năm lăn lộn giữa chốn giang hồ bao phen vào sinh ra tử, vì thế mà có ý kiến cho rằng “Bố Già là sự tổng hòa của mọi hiểu biết. Bố Già là đáp án cho mọi câu hỏi”.
Với cấu tứ hoàn hảo, cốt truyện không thiếu những pha hành động gay cấn, tình tiết bất ngờ và không khí kình địch đến nghẹt thở, Bố Già xứng đáng là đỉnh cao trong sự nghiệp văn chương của Mario Puzo. Và như một cơ duyên đặc biệt, ngay từ năm 1971-1972, Bố Già đã đến với bạn đọc trong nước qua phong cách chuyển ngữ hào sảng, đậm chất giang hồ của dịch giả Ngọc Thứ Lang, làm nên một dịch phẩm kinh điển. Nay, nhân kỉ niệm năm mươi năm ra mắt tác phẩm (1969 - 2019), Đông A xin trân trọng mang đến cho bạn đọc phiên bản đặc biệt với phụ bản tranh minh họa của 12 họa sĩ đương đại Việt Nam, như dịp tái ngộ đầy cảm xúc với những ai yêu mến Bố Già.
Vài nét về tác giả:Mario Puzo (1920 - 1999) là nhà văn, nhà biên kịch người Mỹ gốc Italy nổi tiếng với nhiều tiểu thuyết về đề tài mafia và tội phạm. Bố Già (The Godfather) xuất bản năm 1969 là đỉnh cao của dòng văn chương hư cấu này, đồng thời là tác phẩm đưa Puzo lên tột đỉnh vinh quang. Đây cũng là một trong những tiểu thuyết bán chạy nhất mọi thời đại. Ngoài Bố Già, Mario Puzo còn nổi tiếng với các tiểu thuyết khác như Đất máu Sicily, Luật im lặng, Ông trùm cuối cùng, Cha con Giáo hoàng…',250000,N'Văn Học','Mario Puzo','2019',6,'20190101',1),

(N'Cang Giả Kim Thuật Sư','S002',N'Fullmetal Alchemist - Cang Giả Kim Thuật Sư - Fullmetal Editon - Tập 1
Trong thế giới của những giả kim thuật sư, có một tồn tại đã đi vào huyền thoại và trở thành ước mơ bất cứ ai cũng ao khát - đó chính là "Hòn đá Triết gia".
Bối cảnh của "Fullmetal Alchemist" được đặt trong một thế giới hư cấu, nơi giả kim thuật là một trong những kĩ thuật khoa học tiên tiến nhất con người từng biết đến. Và anh em nhà Elric cũng không là ngoại lệ. Sau thất bại khi cố gắng đem người mẹ dấu yêu từ cõi chết trở về, người anh Edward mất đi chân trái và người em Alphonse mất toàn bộ cơ thể; bằng nỗ lực đến tuyệt vọng, Edward đã hi sinh nốt cánh tay phải của mình để giành lại linh hồn Alphonse và chuyển hóa nó vào trong một bộ giáp.
Kể từ ngày kinh hoàng đó, cả hai đã quyết tâm lên đường tìm kiếm "Hòn đá Triết gia" - thứ duy nhất có thể giúp họ khôi phục lại cơ thể. "Mọi thứ trên đời đều có giá của nó. Để tìm ra "chân lí", chúng tôi sẵn sàng trả giá, kể cả khi cái giá ấy là vô vọng...!"
Mùa thu này, mời các bạn cùng theo chân anh em Elric khám phá thế giới của những GIẢ KIM THUẬT SƯ thông qua một trong những Manga được yêu thích nhất đến từ Nữ tác giả Hiromu Arakawa, nay đã quay trở lại với phiên bản DELUXE - Fullmetal Edition...!
Lần đầu tiên NXB Kim Đồng cho phát hành một bộ sách được đầu tư và nâng cấp cả về nội dung lẫn hình thức, chắc chắn sẽ mang đến một trải nghiệm hoàn toàn mới mẻ với những ai yêu thích và đón đợi siêu phẩm này...! Sách được giữ nguyên các trang màu bên trong, in trên giấy cao cấp và có tới 3 bìa đi kèm. Đặc biệt nhất phải kể đến lớp bìa PVC rất hiếm khi xuất hiện đối với những tác phẩm Manga tại Việt Nam! Xin trân trọng giới thiệu cùng bạn đọc.',69000,N'Kim Đồng','Hiromu Arakawa','2019',8,'20191212',1),

(N'Viết Cho Người Phàm','S003',N'Meb - Viết Cho Người Phàm
Luyện tập chạy bộ, suy nghĩ và ăn uống như một nhà vô địch marathon
Với chiến thắng lịch sử tại giải Boston Marathon 2014, Meb Keflezighi trở thành một tượng đài trong môn chạy bộ đường dài. Người chạy bộ khắp nơi muốn biết một người với kỷ lục cá nhân đứng thứ 15 trong giải, lại đánh bại được cả đoàn đua mạnh nhất trong lịch sử Boston Marathon để trở thành người Mỹ đầu tiên vô địch giải này sau 31 năm ròng.
Với lối mô tả chi tiết khó tin, Meb viết cho người phàm đã giải thích cách mà vận động viên ba lần dự Olympic này chuẩn bị để đối đầu với những người chạy bộ giỏi nhất thế giới. Quan trọng hơn nữa, cuốn sách chỉ dẫn cho những người chạy bộ bình thường nhất cách áp dụng phương pháp tập luyện, chế độ dinh dưỡng và các nguyên tắc về tinh thần giúp anh duy trì sự nghiệp dài hơi, trong đó không chỉ có chiến thắng tại giải Boston 2014, mà còn cả tấm huy chương bạc Olympic và chức vô địch giải New York City Marathon 2009.
Đây là cuốn sách hoàn hảo cho bất kỳ người chạy bộ nào – dù là lính mới hay vận động viên marathon dày dạn – mong muốn cải thiện thành tích và có thêm niềm vui trong chạy bộ.',188000,N'Thế Giới','Meb Keflezighi','2019',7,'20190101',1),

(N'Bên Rặng Tuyết Sơn','S004',N'Bên Rặng Tuyết Sơn (Tái Bản 2019)
Bên Rặng Tuyết Sơn là quyển sách mới trong bộ sách khoa học tâm linh nổi tiếng của dịch giả Nguyên Phong. Khơi nguồn từ vùng núi Himalaya xa xôi và vùng đồng bằng Ấn Độ, Bên Rặng Tuyết Sơn mang đến cho bạn đọc những sự thật vĩ đại về tâm linh và vai trò của việc làm chủ tâm linh cũng như làm chủ số phận. Tác phẩm còn khơi dậy những giá trị cao đẹp như: Tính trung thực, trái tim bao dung, lòng trắc ẩn, sự thông thái, lòng tín ngưỡng và tình yêu bao la.
Câu chuyện bắt đầu từ việc Satyakam đến thung lũng Saraswati để tầm sư học đạo. Nhưng không ngờ rằng, khi đến đây, thì vị đạo sư già đã chờ anh rồi, không những thế, ông còn nói đúng tên anh và biết anh đến gặp ông để làm gì dù rằng anh chưa hề xưng tên cũng như chưa nói mục đích của mình đến đây.
Dài học đầu tiên của Satyakam là quên đi thời gian. Việc này nghe qua tưởng chừng như đơn giản nhưng khi bắt đầu thực hiện lại không đơn giản chút nào. Cũng như việc lắng nghe những âm thanh của vũ trụ như tiếng lá rơi, tiếng gió thổi, tiếng nước reo cũng không dễ dàng thực hiện nếu trong lòng ta vẫn còn nhiều tạp âm. Chúng ta sẽ được trải nghiệm những giây phút bình yên thông qua chuyến hành trình đi tìm chân lý của Satyakam dưới sự hướng dẫn của vị đạo sư trong dãy núi Tuyết Sơn để hiểu rõ hơn về sức mạnh vĩnh hằng của thế giới tâm linh cũng như khám phá chính tiếng nói nội tâm của bản thân mình.',88000,N'Hồng Đức','Swami Amar Jyoti','2019',10,'20191212',12),

(N'Ngày Hôm Nay Mang Tên Hạnh Phúc','S005',N'Ngày Hôm Nay Mang Tên Hạnh Phúc
Rạng đông, khi dãy núi Seorak -ngọn núi cao nhất trong dãy núi Taebaek, thuộc tỉnh Gangwon, đông bắc Hàn Quốc, bắt đầu nhuốm màu đỏ rực tinh khiết và những đám mây bồng bềnh trôi trên bầu trời khoác lên mình một lớp áo dệt bởi vô vàn những tia nắng sớm mai cũng là lúc người ta dễ đắm mình vào trạng thái thiền định yên bình và tĩnh lặng đến mức khó diễn tả bằng lời. Tạo hóa cũng chìm vào cõi thiền. Lời thì thầm của những tia nắng rực rỡ, những dãy núi và mặt biển nhuốm màu đỏ ối của buổi chiều tà, những ngôi sao sáng lấp lánh trên bầu trời đêm, tất cả những thứ ấy tuy bé nhỏ và mộc mạc nhưng nếu người nào cảm nhận được sự kinh ngạc và cảm động đang tràn ngập nơi con tim thì người đó đã sớm trở thành người cầu đạo, người tu thiền.
Mỗi ngày, hãy thử lắng tai nghe những câu chuyện mà thiên nhiên mang đến. Hãy phiêu mình theo điệu nhạc do thiên nhiên tạo nên. Nếu ta ngắm nhìn phong cảnh này bằng cả năm giác quan thì cuộc sống bận rộn sẽ biến mất lúc nào không hay, cả thế giới bỗng chốc sẽ chậm lại và tất cả những gì đẹp đẽ như sự tĩnh lặng, yên bình, hạnh phúc, cảm động, sung túc sẽ bung nở rực rỡ tựa như những bông hoa tuyết. Khi ta tạm dừng dòng suy nghĩ ngổn ngang trong đầu và ghé tai nghe tiếng thở của tạo hóa thì thế giới mà ta đang sống sẽ dần thay đổi sang một góc độ hoàn toàn khác. Từng tế bào trong cơ thể ta chìm đắm vào trạng thái nghỉ ngơi hoàn toàn. Dường như những gì đẹp đẽ nhất, thần bí nhất những tưởng chỉ có trong truyện cổ tích chợt hiển hiện ngay lúc này.
Chúng ta đang sống trong một thế giới mà tất cả đều lặp đi lặp lại từ ngày này sang tháng nọ nhưng chỉ cần ta tạm gác những suy tư sang một bên để lắng nghe tiếng thì thầm của những sinh linh bé nhỏ, yếu ớt hoặc chí ít là lặng ngắm những góc khuất trong chính bản thân mình thì cuộc sống rạng rỡ sẽ mở ra trước mắt ta dưới một góc độ hoàn toàn mới.
Cuộc sống luôn lấp lánh những điều tuyệt vời làm người ta lóa mắt. Chỉ có điều ý thức khiến ta ngần ngại nhìn thẳng vào sự thật cuộc sống mà thôi.
Dạo gần đây, tôi thường hay nghe thấy những câu như thế này: “Cuộc sống này thật mệt mỏi. Bức bối quá. Đau quá. Chết mất thôi. Khổ sở quá.”
Thực ra không phải gần đây tôi mới nghe thấy những lời than vãn này. Không chỉ ở thời điểm hiện tại mà ngay từ thời xa xưa con người ta đã không ngừng than vãn. Liệu ta có thể tìm ra lời giải đáp chính xác và rõ ràng cho vấn đề này không?
Từ trước đến nay đã có rất nhiều bậc thánh nhân, những người thầy hướng dẫn về mặt tâm linh trả lời vấn đề đau khổ này. Mặc dù đã trải qua một thời gian dài nhưng những lời giải đó vẫn mãi là nguồn tri thức to lớn và trở thành kim chỉ nam trong cuộc sống của con người thời hiện đại.
Tuy nhiên, chỉ cần nhìn thoáng qua chúng ta cũng sẽ cảm nhận được rằng lời giải của các bậc thánh nhân, các nhà hiền triết hay những người thầy hướng dẫn về mặt tâm linh thuộc đủ mọi tôn giáo, triết học là khác nhau.
Chúng ta sẽ luôn ở trong trạng thái băn khoăn tự hỏi nên làm theo lời dạy nào, lời dạy nào là gần gũi với ánh sáng chân lí nhất, nên lựa chọn và tin theo tôn giáo nào. Có vẻ như ta sẽ khó có thể tìm được ra đáp án đúng. Bởi vì tất cả là do sự lựa chọn của ta mà thôi.
Nếu dành thời gian nghiền ngẫm những lời giáo huấn của các bậc thánh nhân có chức sắc tôn giáo, những người thầy hướng dẫn về mặt tâm linh hay các nhà hiền triết nổi tiếng của nhân loại, chúng ta sẽ bất ngờ khi nhận ra rằng những lời dạy đó về bản chất là không khác nhau. Mặc dù có thể chúng khác nhau ở phương thức biểu đạt, nội dung, cách thực hiện và định kiến khi nhìn nhận về cuộc sống nhưng nếu đi sâu vào trọng tâm căn bản, ta sẽ nhận ra chúng ở trong mối liên kết hết sức thần bí.
Việc bản chất của những lời giáo huấn tương thông nhau mặc cho những khác biệt về truyền thống tôn giáo, đất nước hay thời đại có ý nghĩa gì? Điều đó có nghĩa rằng dù được gọi bằng bất cứ tên gọi nào đi chăng nữa thì vẫn luôn tồn tại một chân lí căn bản góp phần hình thành nên nền tảng của vũ trụ và cuộc sống này.
Đôi khi những lời giáo huấn ấy được hiểu với những ý nghĩa hoàn toàn khác nhau do sự khác biệt về ngôn ngữ, phương thức biểu đạt, bối cảnh văn hóa nhưng nếu nhìn kỹ vào thuộc tính của những chân lí tương đồng gặp gỡ nhau tại căn nguyên thì khắp cơ thể ta sẽ dâng lên hai dòng cảm xúc vừa xúc động sâu sắc vừa rùng mình.
Mọi chuyện sẽ ra sao nếu chúng ta có thể tìm ra trọng tâm của những lời giáo huấn gặp gỡ nhau tại căn nguyên cho dù giữa chúng có sự khác biệt về truyền thống? Nếu làm được điều đó thì dù có là người theo tôn giáo nào, mang trong mình những tư tưởng triết học và giá trị quan như thế nào, tin tưởng và đi theo thầy nào cũng sẽ không còn quan trọng nữa, ai cũng có thể tin và làm theo lời giáo huấn đó.
Còn gì tuyệt vời hơn việc lời giáo huấn chứa đựng những nội dung mang tính hiện thực đó có thể trực tiếp tác động nhằm giải quyết những vấn đề đau khổ mà bất kỳ ai cũng mắc phải trong cuộc sống?
Cuốn sách này được viết dựa trên những suy nghĩ như vậy, xuất phát từ quan điểm mang tính hiện thực về chân lí, cái mà ta có thể bắt gặp ở căn nguyên của những tư tưởng và lời giáo huấn, không bị trói buộc bởi bất kỳ một khuôn mẫu đặc biệt nào. Đặt trọng tâm xoay quanh hai phương diện “Phải sống như thế nào?”,
“Phải suy nghĩ như thế nào?”, tôi muốn phân tích việc sống trên đời có nghĩa là phải sống với thái độ như thế nào.
Bốn thái độ sống “chấp nhận”, “buông bỏ”, “quán chiếu”, “giác ngộ” được phân tích ở đây là những nội dung mang tính trọng tâm được diễn giải một cách chung nhất không phân biệt tôn giáo, hệ tư tưởng, triết học. Nói cách khác, đó chính là phương hướng cuộc sống của những người có ý chí và chân lý, là trọng tâm trong lời giáo huấn được nhấn mạnh và nhắc nhở thực hiện nhiều lần.
Bốn thái độ sống được phân tích ở nội dung chính trong cuốn sách này là hệ thống thực hiện tốt nhất dẫn ta đến gần hơn với chân lí, giải thoát khỏi khổ hạnh và giải quyết mọi vấn đề của cuộc sống. Nó không phải là tiếng vang trống rỗng hay một cái gì đó tương tự như kỹ thuật, kỹ xảo dùng để giải quyết vấn đề. Nó cũng không phải là suy nghĩ kiểu siêu hình học hay mang tính chủ nghĩa thần bí theo kiểu làm những việc không thực tế. Nó là cách thực hiện mang theo sức mạnh trực tiếp và mãnh liệt. Mỗi giây mỗi phút khi chúng ta cố gắng hòa hợp với cuộc sống, làm việc và nâng cao nhận thức thì cũng là lúc cuộc sống bắt đầu có những thay đổi đáng kinh ngạc.
Gió thổi nhẹ. Ánh sáng phản chiếu từ mặt hồ trong buổi sớm mai làm tinh thần ta tỉnh táo lạ thường. Đột nhiên, chim mòng biển bay vút lên cao tựa như quăng vào không trung sự tự do thầm kín.',139000,N'Lao Động - Xã Hội','Beop Sang','2019',0,'20190101',1),

(N'Cáp Treo Tình Yêu','S006',N'Cáp Treo Tình Yêu
Tác phẩm mới nhất đến từ nhà văn trinh thám hàng đầu Nhật Bản Keigo Higashino
Trong tuần đầu tiên xuất bản (01/11/2016), Cáp treo tình yêu đã nắm giữ vị trí đầu trong bảng doanh số hàng tuần. Và tiếp tục ở trong top 10 nhiều tuần sau đó.
Một nữ nhân viên văn phòng bị hôn phu phản bội,
Một chàng trai ôm mộng tìm được tình yêu đích thực sau năm lần bảy lượt thất bại tình trường,
Một cô gái trẻ gặp phải gã đàn ông dối trá,
Một cặp đôi mới cưới vướng vào rắc rối với bố mẹ vợ.
Mỗi người họ đều ôm trong lòng nỗi phiền muộn riêng. Những cuộc đời tưởng chừng như không có điểm giao thoa ấy lại được gắn kết với nhau tại một khu trượt tuyết lạ kỳ, nơi có khả năng phơi bày sự thật và những điều thầm kín dù chúng ta có được con người ta che đậy kỹ càng tới đâu.
Vậy, sự thật liệu có luôn là điều mà con người ta muốn biết?
Đứng trước tình yêu, con người sẽ trở nên thảm hại, ích kỷ, hoặc nhiều dũng khí đến thế nào?
Những tình tiết bất ngờ trong Cáp treo tình yêu sẽ khiến bạn phải bật cười và tự hỏi điều gì tiếp theo có thể xảy ra.',89000,N'Hà Nội','Keigo Higashino','2019',0,'20190101',1),

(N'Để Có Một Tương Lai','S007',N'Để Có Một Tương Lai
Trong xã hội có rất nhiều mối nguy. Nếu chúng ta đặt một người trẻ vào xã hội mà không tìm cách bảo vệ họ, họ sẽ tiếp nhận những bạo động, căm thù, sợ hãi và bất an mỗi ngày, rốt cuộc họ sẽ bị bệnh. Những câu chuyện của chúng ta, những chương trình tivi, quảng cáo, sách báo đều tưới tẩm các hạt giống khổ đau nơi những người trẻ và cả những người lớn. Chúng ta cần một vài nguyên tắc, vài phương thuốc cho căn bệnh của mình, những gì lành, đẹp và thật để có thể nương tựa vào.
2.500 năm trước, Bụt đã đưa ra các nguyên tắc cho những người đệ tử tại gia của Ngài để giúp họ sống một đời sống bình an, lành mạnh và hạnh phúc. Đó là Năm Giới và nền tảng của mỗi Giới này là chánh niệm. Với chánh niệm, chúng ta ý thức được những gì đang xảy ra nơi thân thể, cảm thọ, tâm hồn và thế giới quanh ta, cũng như ta tránh không gây tổn hại cho mình và cho người.
Học hỏi và thực tập theo Năm Giới và nương tựa Tam Bảo chắc chắn sẽ mang lại an lạc cho bản thân, cho cộng đồng và cho xã hội. Là con người, chúng ta cần có một cái gì để tin tưởng, một cái gì lành, đẹp và thật, một cái gì mà ta có thể tiếp xúc. Trong quyển sách này, Năm Giới được diễn bày theo hình thức mới, đó là Bảo vệ sự sống, Hạnh phúc chân thực, Tình thương đích thực, Ái ngữ và Lắng nghe, Nuôi dưỡng và trị liệu.
Năm Giới chính là tình thương. Thương có nghĩa là hiểu, bảo vệ và mang lại an vui cho đối tượng thương yêu của chúng ta. Giới không phải là luật lệ mà là những nguyên tắc hướng dẫn giúp ta tập sống như thế nào để có thể bảo hộ cho mình và cho những người xung quanh.
Khi có người hỏi: “Bạn có quan tâm đến bản thân không?”, “Bạn có quan tâm đến người bạn đời không”, “Bạn có quan tâm đến Trái đất không?”... cách hay nhất để trả lời là hành trì Năm Giới. Đây là cách dạy bằng thân giáo chứ không phải chỉ bằng lời. Nếu bạn thật sự quan tâm, xin hãy hành trì các Giới này để bảo hộ cho mình và cho mọi người, mọi loài khác nữa. Nếu chúng ta thực tập hết lòng thì tương lai sẽ còn có mặt cho chúng ta và con cháu chúng ta.',155000,N'Thế Giới',N'Thích Nhất Hạnh','2019',5,'20190101',1),

(N'Tiệm Cầm Đồ Thời Gian - Tập 2','S008',N'Tiệm Cầm Đồ Thời Gian - Tập 2

Ngoài nghề chính là kinh doanh tiệm cầm đồ, “vật linh sư” A Lạc nhờ vào năng lực đặc biệt – nhìn thấy vật linh – mà còn nhận thêm nghề tay trái là “thám tử tư”, chuyên điều tra những điều thần bí liên quan đến vật linh.
Ủy thác lần này chính là điều tra tung tích món bảo vật của tiệm đá quý Diệp Thị.
A Lạc dựa theo những manh mối trong cuốn nhật kí của bà Diệp Thái Hân, lần tìm được đến nhà của ông Lý Xương Bình.
Liệu cuối cùng có thể cậu có thể thông qua người nhà họ Lý để tìm được chân tướng hay không?
Sau khi gạt đi lớp sương mù, liệu thứ cậu thấy có phải là một quá khứ xấu xí.
Hay bí mật được hé lộ?',45000,N'Nhà Xuất Bản Phụ Nữ',N'Thiên Xuyên','2019',8,'20190101',1),

(N'Định Mệnh Chiến Tranh','S009',N'Định Mệnh Chiến Tranh
Mỹ và Trung Quốc có thể thoát bẫy Thucydides ?
Đây không phải là một cuốn sách về Trung Quốc. Mà là một cuốn sách về tác động của một Trung Quốc đang trỗi dậy đối với Mỹ và trật tự toàn cầu. Khi một cường quốc đang trỗi dậy đe dọa thế chỗ một cường quốc đang thống trị, hệ quả có khả năng xảy ra nhất chính là chiến tranh. 
Đề cập tới Chiến tranh Peloponnese từng tàn phá Hy Lạp cổ đại, sử gia Thucydides đã giải thích rằng: “Chính sự trỗi dậy của Athens và nỗi sợ hãi mà nó gây ra ở Sparta đã khiến chiến tranh trở thành điều tất yếu.” Tình trạng tương tự đã xảy ra 16 lần trong suốt 500 năm qua. Và 12 lần đã kết thúc trong bạo lực.
Trong lần thứ 17, sự trỗi dậy khôn cưỡng của Trung Quốc đang đi tới chỗ va chạm với một nước Mỹ đang giậm chân tại chỗ. Cả Tập Cận Bình và Donald Trump đều cam kết “khôi phục sự vĩ đại” cho nước mình. Nhưng nếu Trung Quốc không sẵn sàng tiết chế các tham vọng của mình, hoặc Washington không chịu chia sẻ vị thế đứng đầu ở Thái Bình Dương, một cuộc xung đột thương mại, một vụ tấn công mạng, hay một tai nạn trên biển cũng có thể khơi mào cho một cuộc chiến tranh lớn.
Trong cuốn sách này, Allison giải thích tại sao Bẫy Thucydides lại là lăng kính tốt nhất để hiểu rõ sự cạnh tranh giữa Mỹ và Trung Quốc. Liệu Washington và Bắc Kinh có thể chèo lái con thuyền quốc gia của họ vượt qua những bãi cạn nguy hiểm?
+ĐÁNH GIÁ/NHẬN XÉT CHUYÊN GIA:
"Bẫy Thucydides đã xác định một thách thức chính yếu đối với trật tự thế giới: xung đột lợi ích. Tôi chỉ có thể hy vọng mối quan hệ Mỹ-Trung sẽ trở thành trường hợp thứ 5 có thể được giải quyết trong hòa bình, thay vì trở thành trường hợp thứ 13 nổ ra chiến tranh." - Henry Kissinger, cựu Bộ trưởng Bộ Ngoại giao Mỹ.
“Trung Quốc và Mỹ sẽ tạo ra một trật tự quốc tế mới, dựa trên sự thừa nhận rằng cường quốc mới đang trỗi dậy sẽ được trao một vai trò phù hợp trong việc hình thành các quy tắc và thể chế toàn cầu… Trong thế kỷ XXI, Bẫy Thucydides sẽ nuốt chửng không chỉ Mỹ và Trung Quốc, mà cả toàn thế giới.” - Nouriel Roubini, giáo sư tại Trường Kinh doanh Stern thuộc Đại học New York và Chủ tịch của Roubini Global Economics
“Cuốn sách được xây dựng từ những nghiên cứu chuyên sâu trong dự án ‘Bẫy Thucydides’ mà Graham Allison đã dày công xây dựng nên có sức thuyết phục cao, với các lập luận và dẫn chứng có tính thuyết phục. Cuốn sách có cách diễn giải mạch lạc và lôi cuốn. Việc Graham Allison để mở mà không đưa ra khuyến nghị chính sách như thường thấy trong các nghiên cứu của các học giả Mỹ, gợi mở cho mỗi người đọc những suy nghĩ và ý kiến khác nhau. Cuốn sách chắc chắn sẽ gây tiếng vang lớn trong giới học giả và công chúng. Rất nhiều học giả và chính trị gia trên thế giới đã có những đánh giá tích cực về cuốn sách. Hy vọng rằng, như Klaus Schwab, Chủ tịch Diễn đàn Kinh tế Thế giới (WEF) đã đánh giá ‘các bài học trong sách có thể cứu hàng triệu mạng người’.” - Đỗ Mạnh Hoàng, Viện Nghiên cứu Chiến lược Ngoại giao, Học viện Ngoại giao.',246000,N'Hà Nội','Graham Allison','2019',9,'20190101',1),

(N'Bird Box','S010',N'Bird Box
Một tác phẩm được chuyển thể thành phim trên Netflix với sự tham gia diễn xuất của nữ minh tinh đình đám Hollywood Sandra Bullock.
Trở thành phim lẻ thành công nhất của Netflix , hơn 80 triệu tài khoản đã xem trong vòng một tháng
Có thứ gì đó ngoài kia…
Thứ gì đó rất kinh khủng mà không ai muốn đối mặt. Chỉ một cái nhìn thoáng qua là đủ để con người bị cuốn vào cơn cuồng nộ bạo lực và chết chóc. Không ai biết nó là gì và nó đến từ đâu.
Năm năm đã trôi qua kể từ khi thảm họa bí hiểm kia bắt đầu, chỉ còn một vài người sống sót, trong đó có Malorie và hai đứa con của cô. Ẩn náu trong một căn nhà hoang gần bờ sông. Malorie nung nấu ý định chạy trốn đến một nơi an toàn hơn. Bây giờ chính là thời điểm thích hợp để hành động. Thế nhưng hành trình phía trước của Malorie đầy rẫy khó khăn: lênh đênh hai mươi dặm trên sông trong tình trạng bịt mắt, không có gì để dự dẫm ngoài đôi tai nhạy bén của hai đứa con và lòng dũng cảm của chính cô. Chỉ một quyết định sai lầm có thể dẫn đến cái chết. Thứ gì đang bám theo họ? Con người, động vật, hay quỷ dữ?
Chìm trong bóng tối, bị bao vây bởi những âm thanh quen thuộc bị bóp méo, Malorie vừa vật lộn để thích nghi với thế giới mới, vừa hồi tưởng lại kí ức đau buồn về sự ra đi của chị gái và những người bạn cùng nhà. Cô ôm lấy niềm hi vọng mà Tom – anh bạn tốt nhất của cô trong ngôi nhà cũ – đã truyền cho. Cô quyết tâm râ khỏi vùng đất an toàn và đối mặt với câu hỏi cuối cùng: Trong thế giới điên rồ này, niềm tin còn tồn tại hay không?
Đan xen giữa quá khứ và hiện tại, tác phẩm đầu tay của Josh Malerman là một kiệt tác khiến bạn không ngừng hồi hộp cho đến khi khép lại cuốn sách.',98000,N'Hà Nội','Josh Malerman','2019',2,'20190101',1),

(N'Tăng Trưởng Thần Tốc','S011',N'Tăng Trưởng Thần Tốc
Không có doanh nhân hay nhà sáng lập nào không mong muốn xây dựng một công ty đình đám tiếp theo giống như Amazon, Facebook hay AirBnB. Tuy nhiên, những người có thể làm được điều này cực kỳ hiếm. Vậy, điều gì đã ngăn cản các công ty khởi nghiệp tăng trưởng mạnh mẽ - trở thành gã khổng lồ toàn cầu?
Bí mật chính là “Blitzscaling” – thuật ngữ nói về việc tăng trưởng thần tốc. “Blitzscaling” là tập hợp các kỹ thuật tăng trưởng, nhân rộng và thổi bay đối thủ với một tốc độ chóng mặt. Mục tiêu của Bliztzcaling không phải là tăng trưởng từ 0 đến một, mà là từ 1 đến 1 tỷ, càng nhanh càng tốt.
Khi các doanh nghiệp, Startup phát triển với một tốc độ cao, để đạt được các cấp độ tiếp theo, các chiến lược phải trở nên rất khác biệt so với các chiến lược trước đó.
Trong cuốn sách này, nhà đồng sáng lập Linkedln, kiêm nhà đầu tư huyền thoại Reid Hoffman và doanh nhân, nhà văn Chris Yeh đã tiết lộ cách điều hướng những thay đổi cần thiết và vượt qua những thách thức ở mỗi giai đoạn trong vòng đời để một công ty có thể “Tăng trưởng thần tốc”: Từ giai đoạn thiết kế mô hình kinh doanh để tăng trưởng đột phá, xây dựng chiến lược tuyển dụng và quản lý, xác lập vai trò của người sáng lập đến phát triển văn hóa công ty .
Cuốn sách này dành cho bất kỳ ai muốn hiểu các kỹ thuật cho phép một doanh nghiệp phát triển từ con số không trở thành công ty tỷ đô dẫn đầu thị trường. Bất kể bạn là một nhà sáng lập, một nhà quản lý, một nhân viên tiềm năng hay một nhà đầu tư, cuốn sách “Tăng trưởng thần tốc” sẽ giúp bạn đưa ra quyết định tốt hơn trong một thế giới mà tốc độ là lợi thế cạnh tranh then chốt.
Nhận xét về cuốn sách này, tỷ phú Bill Gates không tiếc lời khen ngợi: “Những nghiên cứu thực tiễn mà bạn sắp khám phá và những công cụ bạn sắp nhận được chưa từng quý giá hơn thế này. Đây là thời điểm lý tưởng để đọc cuốn sách này”.
Giám đốc điều hành của Facebook, kiêm tác giả cuốn sách nối tiếng “Lean In” – Sheryl Sanberg nhận xét: “Mô hình Tăng trưởng Thần tốc chỉ ra cách thức mà các công ty có thể xây dựng giá trị cho những khách hàng và những cổ đông trong thời đại số. Tăng trưởng thần tốc trình bày một viễn cảnh nội tại đầy thuyết phục về cách thức mà nền kinh tế mới đang được xây dựng và sự chuyển dịch môi trường kinh doanh toàn cầu.”
Brian Chesky – Nhà sáng lập và Giám đốc điều hành Airbnb đề cử “Tăng trưởng thần tốc” là một trong những cuốn sách bắt buộc phải đọc với giới khởi nghiệp : “Đây là cuốn sách mà thế giới start-up đã trông đợi từ lâu. Tôi không thể nghĩ ra cuốn sách nào khác có thể nắm bắt một cách hoàn hảo các thử thách cụ thể và các cơ hội mà một công ty phải đối mặt ở mỗi giai đoạn tăng trưởng. Cuốn sách này chia sẻ một vài bí mật then chốt để xây dựng các doanh nghiệp toàn cầu, theo định hướng sứ mệnh với tốc độ cao.”',158000, N'Tổng Hợp TP.HCM',N'Reid Hoffman - Chris Yeh','2019',1,'20190101',1),

(N'21 Bài Học Cho Thế Kỷ 21','S012',N'21 Bài Học Cho Thế Kỷ 21
Sau khi tìm hiểu quá khứ và tương lai của nhân loại qua hai cuốn sách gây tiếng vang là Sapiens và Homo deus, Yuval Noah Harari đi sâu vào các vấn đề “ngay tại đây” và “ngay lúc này”, tức các sự kiện hiện tại và tương lai gần nhất của xã hội loài người.
Những triển vọng đầy hứa hẹn của công nghệ sẽ được đưa ra bàn luận bên cạnh những hiểm họa như “đứt gãy” do công nghệ gây ra, việc kiểm soát thế giới bên trong dẫn tới sự sụp đổ của hệ thần kinh hay “tự do trong khuôn khổ”. Chính trị và tôn giáo có còn bắt tay nhau như trong quá khứ hay sẽ thao túng con người theo những cách riêng rẽ, mới mẻ hơn? Và những vấn đề toàn cầu ấy liên quan mật thiết tới hành vi và đạo đức của từng cá nhân riêng lẻ như thế nào? Xét cho cùng, những thách thức lớn nhất và những lựa chọn quan trọng nhất của ngày nay là gì? Ta cần chú ý đến điều gì? Ta nên dạy con cái ta những gì?
“Cuộc khủng hoảng sinh thái đang lấp ló, mối đe dọa của các loại vũ khí hủy diệt hàng loạt [...] và sự trỗi dậy của các công nghệ đột phá mới” là những nỗi lo không của riêng ai; và Harari sẽ đồng hành cùng bạn trên con đường bóc tách từng vấn đề một cách thấu đáo.',209000 ,N'Thế Giới',N'Yuval Noah Harari','2019',4,'20190101',1),

(N'Ikigai - Chất Nhật Trong Từng Khoảnh Khắc','S013',N'Ikigai - Chất Nhật Trong Từng Khoảnh Khắc
Ikigai là một khái niệm đã tồn tại từ rất lâu trong truyền thống văn hóa Nhật Bản. Đây là khái niệm về niềm vui trong cuộc sống thường nhật, hay nói cách khác là lý do mà bạn thức dậy vào mỗi sáng.
Trong cuốn sách, Yukari Mitsuhashi đã phỏng vấn rất nhiều người, bao gồm cả nhà khởi nghiệp hay vận động viên để hỏi về những thứ mà ikigai đã đem đến cho họ, nó đã giúp họ vượt qua những khó khăn trong cuộc sống như thế nào, và bằng cách nào mà họ tìm ra ikigai của chính mình. Thực tế cho thấy mỗi người có một ikigai khác nhau và không phải ai cũng đã tìm ra được ikigai cho bản thân mình.
Ikigai - Chất Nhật trong từng khoảnh khắc là cuốn sách tập trung vào việc tìm kiếm ikigai của bản thân, xác định mục tiêu hoặc đam mê của bạn và sử dụng sự hiểu biết này để đạt được niềm hạnh phúc to lớn hơn trong đời. Dù bạn đang ở độ tuổi nào nếu bạn tìm được ikigai dưới dạng sở thích hoặc các hoạt động khác nó sẽ giúp bạn giữ được sự năng động và tình yêu đối với cuộc sống.
Tùy vào ikigai của bạn là gì mà bạn sẽ nhận được những điều khác nhau từ nó, nhưng nhìn chung hiểu về ikigai của bản thân sẽ giúp bạn cảm thấy hạnh phúc và hài lòng về bản thân mình, có tâm trí điềm tĩnh và vững vàng hơn, kiểm soát cuộc sống thường nhật tốt hơn, tìm thấy được mục đích sống, chủ động hơn và giúp bạn tìm thấy nguồn sinh lực để sống và phát triển. Tất cả những điều này có được là nhờ bạn hiểu bản thân muốn gì và trân trọng điều gì trong cuộc sống.
Cuộc sống luôn luôn đem đến cho chúng ta những khó khăn riêng, và chắc chắn ikigai không phải là một công thức kỳ diệu giúp mọi thứ trở nên hoàn hảo. Nhưng khi có ikigai trên từng chặng đường, chúng ta có thể mãn nguyện khi nhìn lại cả cuộc đời mình.
Với triết lý đơn giản và quan điểm phóng khoáng Ikigai - Chất Nhật trong từng khoảnh khắc sẽ là nguồn cảm hứng giúp bạn theo đuổi hạnh phúc và quan trọng hơn là hiểu được chính mình.
BOX:
Yukari Mitsuhashi là ký giả và nhà văn tự do ở Los Angeles. Cô lớn lên ở Tokyo và trải qua phần lớn tuổi thơ ở Nhật trước khi chuyển đến New York cùng gia đình. Sau khi tốt nghiệp đại học Keio năm 2012, cô bắt đầu làm việc với vai trò dịch giả và nhà văn tự do, đồng thời dành thời gian xây dựng trang blog cá nhân TechDoll.jp. Nhiều bài viết của cô đã được đăng tải trên trang tin BBC World.',72000,N'Tổng Hợp TP.HCM','Yukari Mitsuhashi','2019',3,'20190101',8),

(N'Ẩn Tàng Thư Dantalian - Tập 3','S014',N'Japonisme - Những Điều Rất Nhật Bản
Japonisme – những điều Rất Nhật Bản là một cuốn sách mang đầy hơi thở của xứ sở hoa anh đào, là nguồn cảm hứng vô tận để bạn khám phá nghệ thuật kiếm tìm hạnh phúc, sự đủ đầy cho Kokoro (trái tim và tâm trí) lẫn Karada (thân thể) của mình.
Với cuốn sách, bạn có thể tìm ra ikigai (mục đích) – thứ thôi thúc bạn rời khỏi giường vào mỗi sáng. Phát hiện vẻ đẹp của wabi-sabi – chấp nhận bản chất của sự vô thường, thoáng qua và trân trọng những điều không hoàn hảo. Hay tìm thấy vẻ đẹp trong sự tan vỡ, thông qua nghệ thuật kintsugi.
Mỗi triết lý, mỗi nghệ thuật đều là những lăng kính mới để bạn có thể nhìn vào mọi thứ.
Để rồi từ đó, tìm thấy sự bình yên trong tâm trí, giữa cuộc sống đầy bất định và hỗn độn này.
Về tác giả ERIN NIIMI LONGHURST
Là nhà văn, blogger mang hai dòng máu Nhật – Anh.
Tốt nghiệp Đại học Manchester với bằng Nhân chủng học Xã hội, hiện cô là chuyên viên tư vấn truyền thông xã hội và kỹ thuật số.
Blog của cô, Island Bell, viết về ẩm thực, du lịch và lối sống',109000,N'Hà Nội','Mikumo Gakuto','2019',4,'20190101',4),

(N'Những Điều Rất Nhật Bản','S015',N'Ẩn Tàng Thư Dantalian - Tập 3
Dalian đang làm loạn lên, nổi cáu chửi bới loạn xạ. Cô bé vừa đọc xong hai tập bộ tiểu thuyết nổi tiếng đất kinh kì, nhưng tập ba cuối cùng chưa kịp xuất bản thì tác giả Lenny Lents đã mất từ nửa năm trước. Nhưng mà, Lents lại gửi đến cho tử tước Wesley Disward một lá thư cầu cứu! “Mong ngài hãy cứu vớt, chúng tôi đang bị giam cầm trong một cuốn sách”. Lá thư mới được gửi đi chỉ vài ngày trước thôi. Dalian đòi đến địa chỉ trên thư, để yêu cầu kẻ đó viết nốt tập cuối…
Sự sống luôn tuân theo một chu kỳ, một vòng lặp bất tận được tạo nên từ 3 khái niệm sinh – dưỡng – tử. Những tri thức trong nhân gian được ghi chép lại trong những cuốn sách cũng không nằm ngoài quy luật. Ẩn tàng thư Dantalian – nơi lưu trữ và phong ấn 900.666 cuốn ảo thư. Ẩn tàng thư Raziel – tìm kiếm và tái tạo những bí mật của đất trời – sản sinh ra những cuốn ảo thư mới để khôi phục Bách khoa toàn thư của Đại thiên sứ Raziel. Quan đốt sách lại là người chuyên đi tiêu hủy những cuốn ảo thư mang quyền năng đe dọa đến cuộc sống yên bình của nhân gian. Vòng lặp bất tận ấy lần này kéo Dalian và Huey vào cuộc đụng độ với quan đốt sách Hal Kamhout và ngân độc cơ Flamberge.
Trận đấu vừa mới bắt đầu thì cả hai nhóm phải chợt dừng lại, bởi tiếng la thất thanh đến từ hướng nhà ga. Những xác sống – những thân xác đã bị cướp mất linh hồn chỉ còn lại thể phách, đang tấn công mọi người tại nhà ga. Một kế hoạch điên rồ biến toàn bộ dân kinh thành trở thành xác sống và tấn công Hội nghị phục hồi của những nước thắng trận trong trận đại chiến đầu tiên đang diễn ra tại kinh thành.
Thời gian gấp rút, liệu Hắc độc cơ và kiện thủ cùng Quan đốt sách và ngân độc cơ có thể vượt qua ngoài vòng lặp tranh đấu, mà cùng hợp tác để giải quyết hiểm họa trước mắt?
Tập ba với những cuộc phiêu của cô thiếu nữ và chàng kiện thủ, đối đầu với những cuồng vọng của con người xoay quanh những cuốn sách ác ma với sức mạnh phi thường bắt đầu.',149000,N'Thế Giới','Erin Niimi Longhurst','2019',1,'20190101',1),

(N'Milan Thời Thượng - Sống, Yêu và Tận Hưởng','S016',N'Milan Thời Thượng - Sống, Yêu và Tận Hưởng
Nếu dành tình yêu bất tận cho nước Ý và đặc biệt là kinh đô thời trang Milan, cuốn sách này chính là một cẩm nang du ký trực diện nhất về vẻ đẹp, phong cách thời trang và văn hóa nơi đây.
Bạn yêu thích thể loại du ký, hay chỉ đơn giản yêu cái đẹp xứ sở Milan ?
Cuốn sách được chắp bút bởi 2 biên tập viên kỳ cựu của những tạp chí dành cho phụ nữ hàng đầu nước Ý như : Glamour.it và VanityFair.it. Trong suốt quá trình làm việc, 2 nữ tác giả đã đúc rút được vô số kinh nghiệm làm đẹp, ăn mặc cũng như những địa chỉ uy tín mà các cô gái Milan thường xuyên ghé thăm. Bên cạnh đó, một cuốn sách du ký chất lượng không thể không nhắc đến khía cạnh văn hóa của đất nước ấy : từ việc đi đâu, ăn gì cho đến văn hóa thường thức của một quý cô Milan sẽ được trình bày rốt ráo trong cuốn sách này.
Một phần rất nhỏ trong cuốn sách nhưng không kém phần quan trọng
Chính là bí mật về người đàn ông Milan ! Có cô gái nào mà không quan tâm đến một người đàn ông Milan hào hoa, quyến rũ cơ chứ ? Nhưng đừng dễ dàng để mắc vào lưới của anh chàng hào hoa này đấy nhé ! 2 tác giả của chúng ta sẽ bật mí cho bạn biết những điều bạn chưa bao giờ được nghe về người đàn ông Milan !',129000,N'Thế Giới','Alice Rosati','2019',1,'20191112',1),

(N'BẮT TRẺ ĐỒNG XANH','S017',N'Bắt Trẻ Đồng Xanh (Tái Bản) là một cuốn sách nhỏ, mỏng và chẳng giống ai. Điều đó cũng là tính cách của nhân vật chính, Holden - nổi loạn, thiếu giáo dục, và lạ lùng.
Holden không thích cái gì cả, cậu chỉ muốn đứng trên mép vực của một cánh đồng bao la, để trông chừng lũ trẻ con đang chơi đùa. Holden chán ghét mọi thứ, cậu lan man, lảm nhảm hàng giờ về những thói hư, tật xấu, những trò giả dối tầm thường mà người đời đang diễn cho nhau xem. Holden thô thiển, tục tĩu và chẳng tuân theo khuôn mẫu nào của cuộc sống, cậu cứ là chính cậu thôi.
Bắt Trẻ Đồng Xanh đã mượn suy nghĩ của một chàng trai trẻ để nhìn về cuộc sống một cách hài hước và thông minh. Ngôn từ đơn giản, đôi khi rất thô tục thể hiện con người nhân vật, cuốn sách đi vào lòng người bởi những triết lý giản đơn vẫn đang hiện hữu từng ngày trong cuộc sống. Và rồi sẽ đọng lại trong lòng người đọc một ý nghĩ tưởng như đã quên mất từ lâu: Mình là chính mình.
',75000,N'Hội Văn Học','J. D. Salinger','09-2017',0,'20190101',11),

(N'BÊN NHAU TRỌN ĐỜI','S018',N'Vì một bí mật đau buồn trong quá khứ, Triệu Mặc Sênh và Hà Dĩ Thâm chia tay khi tình yêu giữa họ vừa chớm nở. Dù xa cách nhưng tình yêu của Dĩ Thâm vẫn luôn hướng về Mặc Sênh. Bảy năm sau, Hà Dĩ Thâm đã là một luật sư nổi tiếng, còn Triệu Mặc Sênh trở thành nhiếp ảnh gia. Sau cuộc hội ngộ tại siêu thị, hai người một lần nữa bước vào cuộc sống của nhau, nhưng nỗi đau từ lần chia tay trước đấy vẫn còn đó.
Cuối cùng, dù có chạy trốn như thế nào, muốn quên anh ra sao, số phận vẫn để Mặc Sênh về bên Dĩ Thâm. Một cuộc hôn nhân tưởng chừng hoang đường nhưng lại trói buộc hai con người ấy lại với nhau một lần nữa. Mọi hiểu lầm đều được hóa giải, hạnh phúc lại tràn ngập như ánh nắng mùa xuân.
Một chuyện tình không quá đau thương, không quá phức tạp nhưng lại khiến người đọc mãi không thể quên. Bên nhau trọn đời đã trở lại với ấn bản kỷ niệm mười năm kể từ lần đầu phát hành tại Việt Nam cùng diện mạo mới. Nội dung sách đã được bổ sung một vài tình tiết chưa từng có trong phiên bản trước, đồng thời in kèm lời chúc cùng chữ ký của tác giả Cố Mạn và bộ 5 tranh màu minh họa của họa sĩ ENO Hà Hà Vũ.

',125000,N'Lao Động',N'Cố Mạn','07-2016',0,'20190101',8),

(N'CHO TÔI XIN 1 VÉ ĐI TUỔI THƠ','S019',N'Truyện Cho tôi xin một vé đi tuổi thơ là sáng tác mới nhất của nhà văn Nguyễn Nhật Ánh. Nhà văn mời người đọc lên chuyến tàu quay ngược trở lại thăm tuổi thơ và tình bạn dễ thương của 4 bạn nhỏ. Những trò chơi dễ thương thời bé, tính cách thật thà, thẳng thắn một cách thông minh và dại dột, những ước mơ tự do trong lòng… khiến cuốn sách có thể làm các bậc phụ huynh lo lắng rồi thở phào. Không chỉ thích hợp với người đọc trẻ, cuốn sách còn có thể hấp dẫn và thực sự có ích cho người lớn trong quan hệ với con mình.',80000,N'NXB Trẻ',N'Nguyễn Nhật Ánh','11-2008',4,'20190101',1),

(N'CHUYẾN PHIÊU LƯU KỲ DIỆU CỦA EDWARD TULANE','S020',N'Ngày xưa, trong ngôi nhà trên phố Ai Cập, có một chú thỏ bằng sứ tên là Edward Tulane. Chú được làm ra bởi một người chế tác đồ chơi bậc thầy, được mặc trên người những bộ quần áo tuyệt hảo đặt may riêng.Chú vô cùng ngưỡng mộ và đề cao bản thân, không màng tới cô chủ Abilene đang vô cùng nâng niu chú. Thế nhưng, trên chuyến đi lênh đênh vượt đại dương, một thằng bé đã vô tình quăng chú khỏi mạn tàu. Và từ đó, hành trình lưu lạc của Edward bắt đầu. 
Một chú thỏ bằng sứ có thể đi tới những đâu?
Một chú thỏ bằng sứ có thể sống và yêu như thế nào?
Tình yêu mang vị gì?
Nếu là vị đau, chú có còn nên tiếp tục thương yêu?
Tất cả đã được trả lời với một bút pháp đầy chất thơ trong Chuyến phiêu lưu diệu kỳ của Edward Tulane. Có thể nói rằng, kể từ Bởi vì Winn-Dixie cho tới câu chuyện về thỏ sứ Edward Tulane, Kate Di Camillo cũng vượt qua một hành trình phi thường để giành trọn say mê và mở rộng trái tim cho độc giả.

',80000,N'NXB Hồng Đức','Kate DiCamillo','06-2019',3,'20190101',1),

(N'EM SẼ ĐẾN CÙNG CƠN MƯA','S021',N'“Hôm nay là lần đầu tiên chúng mình gặp nhau với đôi giầy có cổ và có gót. Cũng phải nói thêm, hôm nay cũng là lần đầu tiên anh thấy em mặc chiếc váy liền màu đỏ sẫm. Lần đầu tiên anh thấy em tô son. Lần đầu tiên anh thấy mái tóc em đung đưa mỗi lần em nghiêng đầu, lần đầu tiên anh cảm thấy bồn chồn không yên khi nói chuyện với em.
Tất cả đều là lần đầu tiên, đến nỗi mà khó tìm được một thứ không phải lần đầu tiên.’’
---------
"Anh cũng hiểu, tuy chỉ mang máng, rằng ngay cả giai đoạn hôn thôi cũng cần phải có thời gian. Anh không vội, hơn nữa, em là người sẽ sống cùng anh cả đời nên vẫn còn khối thời gian. Ít ra thì chúng mình đã mất ba năm mới hẹn hò nhau lần đầu, kể từ sau lần nói chuyện đầu tiên. Cho nên, muốn tiến tới được giai đoạn hôn thì cũng phải mất thêm ba năm nữa.
Anh đã nghĩ vậy.
Trong lần trò chuyện năm tiếng này, chúng mình đã tiến gần đến đoạn hôn nhau. (Không biết lúc hôn, cái răng khểnh của em có bị vướng không?) Anh đã nghĩ thế lúc nhìn vào môi em.
Trời tối, chúng mình phải về. Giờ nhìn lại có thể nói lần hẹn hò này là bước mở đầu cho giai đoạn tiếp theo, nhưng thú thật với em là khi ấy, anh không đủ tự tin để nghĩ vậy. Nhiệm vụ trước mắt của anh là phải hẹn được em cho lần sau chứ không phải nghĩ tới chuyện hôn hay cưới em."
(trích "Em Sẽ Đến Cùng Cơn Mưa", Ichikawa Takuji, Mộc Miên dịch)
',90000,N'Nhà Xuất Bản Văn Học','Ichikawa Takuji','08-2018',8,'20191112',12),

(N'GIẾT CHẾT CON CHIM NHẠI','S022',N'Nào, hãy mở cuốn sách này ra. Bạn phải làm quen ngay với bố Atticus của hai anh em - Jem và Scout, ông bố luật sư có một cách riêng, để những đứa trẻ của mình cứng cáp và vững vàng hơn khi đón nhận những bức xúc không sao hiểu nổi trong cuộc sống. Bạn sẽ nhớ rất lâu người đàn ông thích trốn trong nhà Boo Radley, kẻ bị đám đông coi là lập dị đã chọn một cách rất riêng để gửi những món quà nhỏ cho Jem và Scout, và khi chúng lâm nguy, đã đột nhiên xuất hiện để che chở. Và tất nhiên, bạn không thể bỏ qua anh chàng Tom Robinson, kẻ bị kết án tử hình vì tội hãm hiếp một cô gái da trắng, sự thật thà và suy nghĩ quá đỗi đơn giản của anh lại dẫn đến một cái kết hết sức đau lòng, chỉ vì lý do anh là một người da đen.
Cho dù được kể dưới góc nhìn của một cô bé, cuốn sách Giết con chim nhại không né tránh bất kỳ vấn đề nào, gai góc hay lớn lao, sâu xa hay phức tạp: nạn phân biệt chủng tộc, những định kiến khắt khe, sự trọng nam khinh nữ… Góc nhìn trẻ thơ là một dấu ấn đậm nét và cũng là đặc sắc trong Giết con chim nhại. Trong sáng, hồn nhiên và đầy cảm xúc, những câu chuyện tưởng như chẳng có gì to tát gieo vào người đọc hạt mầm yêu thương.
Gần 50 năm từ ngày đầu ra mắt, Giết con chim nhại, tác phẩm đầu tay và cũng là cuối cùng của nữ nhà văn Mỹ Harper Lee vẫn đầy sức hút với độc giả ở nhiều lứa tuổi.
Thông điệp yêu thương trải khắp các chương sách là một trong những lý do khiến Giết con chim nhại giữ sức sống lâu bền của mình trong trái tim độc giả ở nhiều quốc gia, nhiều thế hệ. Những độc giả nhí tìm cho mình các trò nghịch ngợm và cách nhìn dí dỏm về thế giới xung quanh. Người lớn lại tìm ra điều thú vị sâu xa trong tình cha con nhà Atticus, và đặc biệt là tình người trong cuộc sống, như bé Scout quả quyết nói “em nghĩ chỉ có một hạng người. Đó là người."
',120000,N'Nhà Xuất Bản Văn Học','Harper Lee','12-2018',6,'20190101',11),

(N'Hai Vạn Dặm Dưới Biển','S023',N'Truyện viễn tưởng hay giả tưởng đã có khá nhiều nhà văn trên thế giới thể hiện trong tác phẩm của mình. Cũng là trí tưởng tượng, nhưng khác với truyện cổ tích hay thần thoại, tiểu thuyết giả tưởng thường mang đậm chất hiện thực, sống động.
Hai Vạn Dặm Dưới Đáy Biển là một cuốn tiểu thuyết giả tưởng hiện đại không chỉ dành cho lứa tuổi thiếu nhi mà còn dành cho mọi thế hệ người đọc.
Giáo sư Aronnax cùng anh bạn giúp việc vui tính Conseil là những người say mê khám phá sinh vật biển. Họ đã quyết định khám phá bí mật của quái vật biển. Được sự giúp đỡ của anh chàng thợ săn cá voi siêu hạng Ned Land, họ đã sẵn sàng một cuộc đi săn mà không biết có bao điều nguy hiểm đang chờ đợi mình ở phía trước. Bất ngờ đến với họ khi phát hiện ra con cá voi khổng lồ làm bằng sắt, nhưng tất cả đều không kịp, họ bị bắt làm tù binh trên chiếc tàu của thuyền trưởng Nemo. Và bất đắc dĩ, họ phải tham ra chuyến hành trình trên biển dài ngày. Một thế giới kỳ thú của đại dương đã hiện ra cùng cuộc phiêu lưu của đoàn thám hiểm và thuyền trưởng Nemo: Tham gia chuyến đi săn dưới đáy biển, thoát khỏi cá mập nguy hiểm, chạy trốn những người thổ dân, khai thác kim cương dưới đáy biển, khám phá nhiều vùng đất mới và cuối cùng là mắc kẹt trong núi băng ở Bắc Cực…
Câu chuyện ly kỳ và hấp dẫn ngay từ lúc bắt đầu đến khi ta gấp sách lại sẽ khiến độc giả nhỏ tuổi thích thú, say mê. Nó xứng đáng là cuốn sách gối đầu giường cho những ai say mê khám phá. Sách được in màu, trình bày đẹp, có kèm tranh minh họa sinh động, nằm trong bộ truyện ngắn 12 cuốn Văn học kinh điển dành cho thiếu nhi.',89000,N'Nhà Xuất Bản Văn Học','Jules Verne','08-2015',0,'20190101',10),

(N'HÃY NHẮM MẮT KHI ANH ĐẾN','S024',N'Có bạn trai là một thần thám thông minh, cao ngạo, không hiểu nhân tình thế thái, lúc nào cũng cho mình là nhất.
Khi hẹn hò, anh nói: “Anh không có hứng thú với mấy trò kiểu này. Nhưng nếu em cứ năm phút hôn anh một lần, anh có thể cùng em làm bất cứ việc vô vị nào.”
Khi có chút ghen tuông, anh nói: “Trong lúc em đi tiễn người đàn ông yêu thầm mình thì bạn trai em ở nhà vất vả nướng bánh quy cho em.”
Khi gần gũi, anh nói: “Tuy anh không có kinh nghiệm nhưng tư chất và năng lực lĩnh hội của anh xuất sắc hơn người thường. Ngoài ra, khả năng quan sát của anh cũng rất tốt, anh sẽ làm tốt mọi chuyện.”
Khi cầu hôn, anh nói: “Nếu nhất định phải khái quát một câu, thì đó là: Anh yêu em, bằng cả sinh mệnh và trí tuệ của anh.”
…
Tôi đã đưa anh từ thế giới cô độc về cuộc sống bình thường ấm áp. Còn anh dẫn dắt tôi từ cuộc sống bình yên bước vào cuộc đời đầy thử thách và khó quên.',119000,N'NXB Văn Học',N'Đinh Mặc','02-2014',4,'20190101',10),

(N'KHẢI HOÀN MÔN','S025',N'Ravic, một bác sĩ tài năng người Đức, đến Paris trong hành trình trốn chạy đế chế Quốc xã tàn bạo. Đã quen với những lần bị truy đuổi, bị bắt giam và bị trục xuất, Ravic vẫn trụ vững được trước những nỗi bất hạnh mà số phận của một người lưu vong đã ném vào anh. Cuộc sống của anh từ lâu chỉ tính bằng ngày, với một mục đích duy nhất: trả thù tên Quốc xã đã hành hạ anh và bức tử người bạn gái của anh khi còn ở Đức. Thế nhưng, cuộc sống, hay chính phép màu từ thành phố của sự lãng mạn, đã mang đến cho anh một niềm an ủi dưới cái tên Joan Madou. Tình yêu với nữ diễn viên xinh đẹp đã một lần nữa gieo vào lòng chàng bác sĩ tài hoa niềm hy vọng về một cuộc sống ấm êm, hạnh phúc giữa những giây phút tăm tối nhất của cuộc đời.',120000,N'NXB Văn Học','Erich Maria Remarque','12-2016',5,'20191115',10),

(N'KHÔNG GIA ĐÌNH','S026',N'Không Gia Đình (Bìa Cứng) là cuốn sách được xếp vào danh mục văn học thiếu nhi nhưng rõ ràng, với những gì Không Gia Đình đã kể thì đây là cuốn sách dành cho mọi lứa tuổi ở mọi quốc gia, mọi tầng lớp.
Kể về một chuyến phiêu lưu mà Rêmi là nhân vật chính – một đứa trẻ nghèo khổ, cô độc, không có người thân - Không Gia Đình như một bài ca khẳng định giá trị của lao động, của nhân cách và tình cảm con người.
Trong câu chuyện, cuộc đời Rêmi gắn liền với gánh xiếc rong, với những thử thách mà em gặp phải trên đường đời trải rộng khắp nước Pháp tươi đẹp. Rêmi lớn lên trong đau khổ, lang thang mọi nơi, bị tù đày... Em đã phải chung đụng với rất nhiều hạng người, sống ở khắp mọi nơi, “nơi thì lừa đảo, nơi thì xót thương”. Nhưng dù trong hoàn cảnh nào, em vẫn đứng thẳng lưng, ngẩng cao đầu, giữ phẩm chất làm người - điều em đã học từ cụ Vitali trong cuộc đời lang bạt của mình.
Không Gia Đình là câu chuyện sẽ đọng lại trong lòng độc giả một chút thương cảm với những mảnh đời nghèo khó, bấp bênh ngoài xã hội nhưng cũng vừa nhen nhóm một niềm tin và hy vọng mãnh liệt vào giá trị của lao động, của sự kiên cường. Đây thực sự là một cuốn sách hay và giá trị hơn cả một giá sách dạy phương pháp làm người.',150000,N'NXB Văn Học','Hector Malot','05-2017',1,'20190101',12),

(N'MẮT BIỄC','S027',N'Mắt biếc là một tác phẩm được nhiều người bình chọn là hay nhất của nhà văn Nguyễn Nhật Ánh. Tác phẩm này cũng đã được dịch giả Kato Sakae dịch sang tiếng Nhật để giới thiệu với độc giả Nhật Bản. 
“Tôi gửi tình yêu cho mùa hè, nhưng mùa hè không giữ nổi. Mùa hè chỉ biết ra hoa, phượng đỏ sân trường và tiếng ve nỉ non trong lá. Mùa hè ngây ngô, giống như tôi vậy. Nó chẳng làm được những điều tôi ký thác. Nó để Hà Lan đốt tôi, đốt rụi. Trái tim tôi cháy thành tro, rơi vãi trên đường về.”
… Bởi sự trong sáng của một tình cảm, bởi cái kết thúc buồn, rất buồn khi xuyên suốt câu chuyện vẫn là những điều vui, buồn lẫn lộn …  ',110000,N'NXB Trẻ',N'Nguyễn Nhật Ánh','07-2019',2,'20190101',2),

(N'ÔNG GIÀ VÀ BIỂN CẢ','S028',N'Ông Già Và Biển Cả (tên tiếng Anh: The Old Man and the Sea) là một tiểu thuyết ngắn được Ernest Hemingway viết ở Cuba năm 1951 và xuất bản năm 1952. Tác phẩm là truyện ngắn dạng viễn tưởng và là một trong những đỉnh cao trong sự nghiệp sáng tác của nhà văn, đoạt giải Pulitzer năm 1953.
Nhân vật trung tâm của các phẩm là một ông già đánh cá người Cu-ba, người đã chiến đấu trong ba ngày đêm với con cá kiếm khổng lồ trên vùng biển Giếng Lớn khi ông câu được nó. Sang ngày thứ ba, ông dùng lao đâm chết được con cá, buộc nó vào mạn thuyền và lôi về nhưng đàn cá mập đánh hơi thấy và lăn xả tới, ông lại đem hết sức tàn chống chọi với lũ cá mập, phóng lao, thậm chí cả mái chèo để đánh chúng. Ông giết được nhiều con, đuổi được chúng đi, nhưng con cá kiếm của ông chỉ còn trơ lại một bộ xương khổng lồ. Ông lão trở về khi đã khuya, đưa được thuyền vào cảng, về đến lều, ông nằm vật xuống và chìm vào giấc ngủ, mơ về những con sư tử.
Anders Österling, Thư ký thường trực Viện hàn lâm Thụy Điển đã đánh giá về tác phẩm: “Trong khuôn khổ một câu chuyện giải trí mở ra bức tranh xúc động về số phận con người; câu chuyện là lời ngợi ca tinh thần tranh đấu của con người, không quy phục cho dù không đạt được thắng lợi vật chất, là lời ngợi ca chiến thắng tinh thần ngay cả khi bại trận. Vở kịch diễn ra ngay trước mắt chúng ta, từng giờ từng giờ một, các chi tiết gay cấn ngày một dồn dập và ngày càng chất nặng ý nghĩa. “Nhưng con người sinh ra không phải là để thất bại” - cuốn sách nói - “Con người có thể bị tiêu diệt chứ không thể bị đánh bại”. Nguyên lý “tảng băng trôi” - một phần nổi, bảy phần chìm - được tác giả sử dụng triệt để trong tác phẩm, tạo nên một mạch ngầm văn bản với các lớp nghĩa chưa được phô bày. Tác phẩm là bản anh hùng ca ca ngợi sức lao động và khát vọng của con người.
Văn phong của Hemingway giản dị, trong sáng, ẩn chứa nhiều triết lý sâu sắc về tự nhiên và con người. chất liệu sống ngồn ngộn, độc thoại nội tâm, tình huống biến hóa, căng thẳng, đa nghĩa và đa thanh.',45000,N'NXB Văn Bản','Ernest Hemingway','2018',2,'20190101',9),

(N'PHÍA NAM BIÊN GIỚI PHÍA TÂY MẶT TRỜI','S029',N'Cuốn tiểu thuyết chứa đựng nhiều nhất con người thật của Haruki Murakami và là câu chuyện đơn giản nhất mà Murakami từng kể. Tuy vậy, đơn giản không có nghĩa là dễ hiểu, và một lối kể chuyện giản dị không loại bỏ những nỗ lực kín đáo trong việc thoát ra khỏi những lối đi văn chương đã cũ mòn.
“Sự kết nối” dễ thấy giữa Phía Nam biên giới, phía Tây mặt trời và những tác phẩm khác của Murakami có lẽ là năng lực đặc biệt của nhà văn Nhật Bản đối với cách tạo ra và xử lý cái bí ẩn. Không có mật độ dày đặc như trong Biên niên ký chim vặn dây cót hay Kafka bên bờ biển, cái bí ẩn ở đây giống như những đoạn nhạc jazz biến tấu ngẫu hứng trên nền của những bản nhạc cũ, và chính là cái để lại dư vị lâu nhất cho người đọc.
"Có những gì?” có lẽ là câu hỏi mà cuốn sách nhỏ của Haruki Murakami đặt ra. Có những gì ở phía Nam biên giới, khi đó không chỉ là nước Mêxicô. "Có những gì" ở phía Tây mặt trời, khi đó không chỉ là một chứng bệnh của những người nông dân Xibêri sống trong cảnh ngày đêm không phân cách.
Và có những gì trong những diễn tiến cuộc đời mỗi con người? Không chỉ cuộc đời ít chi tiết của Shimamoto-san mới gây băn khoăn, mà ngay cả ba giai đoạn được miêu tả hết sức rõ ràng của cuộc đời Hajime cũng không hoàn toàn làm thỏa mãn những người quen với những văn chương được tác giả chú tâm giải thích kỹ càng.
Phía Nam biên giới, phía Tây mặt trời không yêu cầu người đọc diễn giải. Rất nhiều chi tiết trong đó thuộc về “tiểu sử ngoài đời” của Murakami, nhưng câu chuyện đơn giản được kể trên nền nhạc của Nat King Cole và Duke Ellington, với hương vị lạ lùng của những ly cocktail Daiquiri và Robin’s Nest có một khả năng đặc biệt: nó không cho phép mọi cách giải thích dễ dãi.
Những câu hỏi liên tiếp hiện ra trong tâm trí Hajime, về ý nghĩa cuộc đời cũng như của từng trải nghiệm dù nhỏ đến đâu, sẽ dần truyền sang người đọc, và đến khi kết thúc, rất có thể sự hoang mang về ranh giới giữa thực và hư, chân thành và giả tạo, quy tắc và ngoại lệ sẽ là điều duy nhất mà người đọc “gặt hái” được.
Điều này cũng không thật sự lạ, vì, đã trở thành quy luật, những câu trả lời thì qua đi, còn câu hỏi thì ở lại.',85000,N'Nhà Xuất Bản Hội Văn Học','Haruki Murakami','03-2018',1,'20190101',1),

(N'TÔT-TÔ-CHAN CÔ BÉ BÊN CỦA SỔ','S030',N'Những cuộc phỏng vấn ở xà lim với kẻ ăn thịt người ham thích trò đùa trí tuệ, những tiết lộ nửa chừng hắn chỉ dành cho kẻ nào thông minh, những cái nhìn xuyên thấu thân phận và suy tư của cô mà đôi khi cô muốn lảng trá Clarice Starling đã dấn thân vào cuộc điều tra án giết người lột da hàng loạt như thế, để rồi trong tiếng bức bối của chiếc đồng hồ đếm ngược về cái chết, cô phải vật lộn để chấm dứt tiếng kêu bao lâu nay vẫn đeo đẳng giấc mơ mình: tiếng kêu của bầy cừu sắp bị đem đi giết thịt.
Sự im lặng của bầy cừu hội tụ đầy đủ những yếu tố làm nên một cuốn tiểu thuyết trinh thám kinh dị xuất sắc nhất: không một dấu vết lúng túng trong những chi tiết thuộc lĩnh vực chuyên môn, với các tình tiết giật gân, cái chết luôn lơ lửng, với cuộc so găng của những bộ óc lớn mà không có chỗ cho kẻ ngu ngốc để cuộc chơi trí tuệ trở nên dễ dàng. Bồi đắp vào cốt truyện lôi cuốn đó là cơ hội được trải nghiệm trong trí não của cả kẻ gây tội lẫn kẻ thi hành công lý, khi mỗi bên phải vật vã trong ngục tù của đau đớn để tìm kiếm, khẩn thiết và liên tục, một sự lắng dịu cho tâm hồn.',55000,N'NXB Thời Đại','Tetsukoku Royanagi','12-2011',5,'20190101',7),

(N'SỰ IM LẶNG CỦA BẦY CỪU','S031',N'Totto-chan: Cô bé bên cửa sổ (Nhật: Madogiwa no Totto-chan?), tiếng Anh: Totto-Chan: The little girl at the window, là cuốn tự truyện của Kuroyanagi Tetsuko.
Hơn 7 triệu bản của cuốn sách này đã được bán ở Nhật Bản. Ngay trong năm đầu tiên, năm 1979, 4,5 cuốn đã được bán. Đây là cuốn sách bán chạy nhất ở Nhật sau Thế chiến thứ hai.
Totto-chan nghĩa là "bé Totto", tên thân mật hồi nhỏ của tác giả Kuroyanagi Tetsuko. Totto-chan sinh trưởng trong một gia đình hạnh phúc, có cha là nghệ sĩ vĩ cầm, mẹ là ca sĩ opera, nhà em còn nuôi con chó lớn tên Rocky. Trước khi em sinh ra, cha mẹ luôn nghĩ em là con trai nên đã đặt tên con là "Toru", nghĩa là vang xa, thâm nhập. Nhưng vì Totto-chan là con gái nên gia đình đã đổi tên em thành Tetsuko. Cha của em thường gọi em một cách thân mật là "Totsky".
Mới sáu tuổi, Totto-chan đã bị thôi học ở trường vì em quá năng động và lạ lùng so với các bạn. Mẹ của Totto-chan biết ngôi trường bình thường không thể hiểu con gái, bà đã xin cho em vào học tại Tomoe Gakuen (Trường Tomoe) của thầy hiệu trưởngKobayashi Sosaku... Nhờ sự giáo dục của thầy hiệu trưởng Kobayashi, học sinh Tomoe đều trở thành những người tốt và thành đạt trong xã hội. Totto-chan vẫn nhớ mãi lời thầy Kobayashi nói: “Em thật là một cô bé ngoan”. “Nếu không học ở Tomoe”, tác giả viết, “nếu không được gặp thầy Kobayashi, có lẽ tôi đã là một người mang đầy mặc cảm tự ti với cái mác ‘đứa bé hư’ mà mọi người gán cho”.
Tetsuko cũng dành những trang cuối của tác phẩm để viết về các bạn bè cùng lớp của mình và cả cuộc sống sau này của họ. Người đã trở thành nhà khoa học, người chuyên trồng hoa lan, người trở thành nhà giáo dục và nghệ sĩ nhưng cũng có người đã qua đời vì bệnh tật...',115000,N'Nhà Xuất Bản Hội Văn Học','Thomas Harris','12-2018',6,'20190101',1)
GO

INSERT INTO TheLoai 
VALUES (N'Văn Học'),
(N'Truyện Tranh'),
(N'Thể Thao'),
(N'Tôn Giáo'),
(N'Kỹ Năng Sống'),
(N'Tiểu Thuyết')
GO

INSERT INTO LoaiSach
VALUES ('S001',1),
('S002',2),
('S003',3),
('S004',4),
('S005',5),
('S006',6),
('S007',4),
('S008',2),
('S009',5),
('S010',3),
('S011',5),
('S012',3),
('S013',5),
('S014',1),
('S015',6),
('S016',6),
('S017',4),
('S018',1),
('S019',4),
('S020',1),
('S021',4),
('S022',4),
('S023',1),
('S024',1),
('S025',1),
('S026',1),
('S027',4),
('S028',1),
('S029',4),
('S030',1),
('S031',4)
GO

INSERT INTO LichSuMua(IDND,TongTien,NgayMua)
VALUES (1,30000,GETDATE()),
(2,40000,GETDATE()),
(1,50000,GETDATE())
GO

INSERT INTO SachDaMua 
VALUES ('S001',1,2),
('S002',2,2)

SELECT * FROM SachDaMua

SELECT * FROM Sach WHERE IDSach = 'S001'